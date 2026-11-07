# Hide Breadcrumbs 1.0.0

Hide Breadcrumbs 1.0.0 is the first public release of the status-bar breadcrumb
tweak for iOS 18.

## Highlights

- Hides the "Back to App" breadcrumb in the SpringBoard status bar.
- Leaves time, carrier, signal, Wi-Fi, battery, and other indicators unchanged.
- Removes the breadcrumb before it is created, so there is no leftover gap.
- No preference pane or configuration.
- Rootless and RootHide packages.

## Compatibility

| Build | Architecture | Compatibility |
|---|---|---|
| RootHide | `iphoneos-arm64e` | Tested on iOS 18.4.1 (Dopamine 3, RootHide) |
| Rootless | `iphoneos-arm64` | Expected to work on iOS 18+ rootless jailbreaks |

Tested on iOS 18.4.1 (Dopamine 3, RootHide) on iPhone 11 Pro Max. The tweak
requires iOS 18.0 or later. The rootless build is expected to work on iOS 18+
rootless jailbreaks.

## Assets

- `com.burc334.hidebreadcrumbs_1.0.0_iphoneos-arm64e.deb`
- `com.burc334.hidebreadcrumbs_1.0.0_iphoneos-arm64.deb`
- `SHA256SUMS.txt`

## Install

1. Download the deb matching your jailbreak.
2. Install it with Sileo, Zebra, or Filza.
3. Respring.

## Verification

Verify the downloaded deb against `SHA256SUMS.txt` before installing it.

## Notes

This release uses GitHub Releases and the GitHub Pages depiction. No APT
repository is required.
