# Build

The following instructions assume Xcode 13.3 on macOS 12.3.

## Pitfalls

* Make sure `MastodonKit` is fetched _as a git submodule_. (For example, Xcode's git clone functionality seems to not do this!) This appears to be a
custom fork called 3.0 that's significantly different from the public MastodonKit. So don't try and pull the regular MastodonKit using CocoaPods.

* You need an Apple Developer ID. In Xcode, head to Signing & Capabilities and set your ID's team.

* QuickToot and Mastonaut need to be in the same team.

* That team ID (the above UI will show it; it looks something like `74J34U3R6X`) is hardcoded. Adjust `MastonautPersistentContainer.swift` accordingly:

```swift
class MastonautPersistentContainer: NSPersistentContainer
{
	static let appGroup = "(insert enter your Team ID here).app.mastonaut.mac"
```

Otherwise, it will build but immediately crash.

