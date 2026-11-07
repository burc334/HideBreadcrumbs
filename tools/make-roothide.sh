#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ROOTLESS_DEB="${1:-$(ls -t "$PROJECT_DIR"/packages/*_iphoneos-arm64.deb | head -1)}"
OUT_DEB="${2:-${ROOTLESS_DEB%_iphoneos-arm64.deb}_iphoneos-arm64e.deb}"
WORK="$(mktemp -d /tmp/hidebreadcrumbs-roothide.XXXXXX)"

cleanup() { rm -rf "$WORK"; }
trap cleanup EXIT

dpkg-deb -x "$ROOTLESS_DEB" "$WORK/root"
dpkg-deb -e "$ROOTLESS_DEB" "$WORK/DEBIAN"

if [ -d "$WORK/root/var/jb" ]; then
    shopt -s dotglob
    mv "$WORK/root/var/jb"/* "$WORK/root/"
    rm -rf "$WORK/root/var"
fi

DYLIB="$WORK/root/Library/MobileSubstrate/DynamicLibraries/HideBreadcrumbs.dylib"
if [ ! -f "$DYLIB" ]; then
    echo "missing dylib: $DYLIB" >&2
    exit 1
fi

rel="${DYLIB#"$WORK/root"}"
install_name_tool -id "$rel" "$DYLIB"
install_name_tool -change "@rpath/CydiaSubstrate.framework/CydiaSubstrate" \
    "@loader_path/.jbroot/usr/lib/libsubstrate.dylib" "$DYLIB"
install_name_tool -change "/usr/lib/libsubstrate.dylib" \
    "@loader_path/.jbroot/usr/lib/libsubstrate.dylib" "$DYLIB" 2>/dev/null || true
install_name_tool -change "/var/jb/usr/lib/libsubstrate.dylib" \
    "@loader_path/.jbroot/usr/lib/libsubstrate.dylib" "$DYLIB" 2>/dev/null || true

for rpath in /var/jb/Library/Frameworks /var/jb/usr/lib \
             "@loader_path/.jbroot/Library/Frameworks" "@loader_path/.jbroot/usr/lib"; do
    install_name_tool -delete_rpath "$rpath" "$DYLIB" 2>/dev/null || true
done

ldid -S "$DYLIB"

sed -i '' 's/^Architecture: .*/Architecture: iphoneos-arm64e/' "$WORK/DEBIAN/control"
rm -rf "$WORK/root/DEBIAN"
cp -R "$WORK/DEBIAN" "$WORK/root/DEBIAN"
dpkg-deb -Zzstd --build --root-owner-group "$WORK/root" "$OUT_DEB"

echo "Built $OUT_DEB"
