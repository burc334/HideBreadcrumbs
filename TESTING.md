# Hide Breadcrumbs — testing

## Build 1.0.0 — final metadata release

**Built:** 2026-11-07
**Installed:** final metadata 1.0.0 RootHide build installed 2026-11-07
**Device / iOS / jailbreak:** iPhone 11 Pro Max, iOS 18.4.1 (22E252),
Dopamine 3 + RootHide, arm64e

**RootHide deb:**
`builds/com.burc334.hidebreadcrumbs_1.0.0_iphoneos-arm64e.deb`
SHA-256: `ca4b5c4acc009fd661661f8b5dd7e7b9f1ac8083e9a5d971bde5a0213123ce71`

**Rootless deb:**
`builds/com.burc334.hidebreadcrumbs_1.0.0_iphoneos-arm64.deb`
SHA-256: `3b0877de94e08f3f4bcd6117499c0f2e37205a6f2c26c17d5ab5c3491fd1d38a`

**Install result:** final metadata RootHide build
(`ca4b5c4acc009fd661661f8b5dd7e7b9f1ac8083e9a5d971bde5a0213123ce71`)
installed successfully; remote package hash matched; package status `ii`; the
installed dylib matched the package payload
(`cc511692045d85cf1a2cf0d52de2b6165f41dba2bcc2915eb0e0db02dca31329`) before
respring. RootHide then re-signed the installed dylib in place
(`be9b5210093fb5e62fe1347406a99210f9b908ea1fe52ce48465eb70f6838097`); the
difference is 40 bytes in the signature/UUID, with load commands and hook
selectors unchanged. SpringBoard respringed.
**Log result:** not applicable — no probe/logging build.
**Crash result:** no safe mode; SpringBoard running (`launchctl list` PID 10219,
last exit `-9` from the intentional respring). No new crash report found.

### Static verification

- Rootless payload: only `HideBreadcrumbs.dylib` + `HideBreadcrumbs.plist`
  under `var/jb/Library/MobileSubstrate/DynamicLibraries`.
- RootHide payload: only the same two files under
  `Library/MobileSubstrate/DynamicLibraries`.
- Both dylibs are fat arm64 + arm64e.
- Rootless links `@rpath/CydiaSubstrate.framework/CydiaSubstrate`.
- RootHide links `@loader_path/.jbroot/usr/lib/libsubstrate.dylib`.
- Filter plist targets `com.apple.springboard` only.
- `Depends: ellekit, firmware (>= 18.0)`.
- `Depiction` / `SileoDepiction` point to the planned Pages URLs.
- No preference bundle, icon, launchd, daemon, or `/var/jb` string in the
  RootHide payload.
- No personal paths, credentials, or debug strings in either dylib.
- The hook returns `NO` from
  `+[SBDeviceApplicationSceneStatusBarBreadcrumbProvider _shouldAddBreadcrumbToActivatingSceneEntity:sceneHandle:withTransitionContext:]`.

### Device test

- [x] RootHide build installs with no dependency error.
- [x] Respring completes; no safe mode.
- [x] User confirmed the breadcrumb is hidden on the behavior build.
- [x] Status bar and unrelated UI remained normal during the test.
- [x] Reinstall the final metadata RootHide build.
- [x] Confirm the final metadata build still hides the breadcrumb.

### Result / notes

All device tests pass. The final metadata 1.0.0 RootHide build is installed and
respringed; it has the same source and hook, with the depiction fields added to
the package control. The user confirmed the final build works on 2026-11-07.
