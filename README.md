## About

This is a fork of **Mastonaut** by @brunophilipe, whose original marketing page
you can still look at [here](https://mastonaut.app). His latest version 1.3.9
can still be [installed from the App Store](https://apps.apple.com/us/app/mastonaut/id1450757574).

### Some features since 1.3.9

(As of 1.9.1. Features marked with a mountain ⛰️ are also available for macOS 10.13 High Sierra through macOS 11 Big Sur; all other features require macOS 12 Monterey or newer.)

#### Accessibility

* The font size of statuses can be increased
* Assorted accessibility improvements ⛰️

#### Composing

* Edit your toots ⛰️
* Autocomplete for hashtags (1.3.9 already had autocomplete for user names)
* Autocomplete for emoji, e.g. `:cat:`
* Open multiple compose windows at once

#### Notifications

* Filter notifications by type (for example, to only see mentions)
* Support for seeing and responding to follow requests

#### Search

* Search for (already known) toots by text or their URL ⛰️

#### Timeline

* Pull to refresh ⛰️
* View a list as a column ⛰️
* View your favorites or bookmarks as a column ⛰️
* Follow hashtags in the Home timeline

#### Viewing

* See if a toot has been edited, and view previous versions ⛰️
* The font face and size can be customized.
* Pull-to-refresh on threads
* Interaction statistics (how many replies, boosts, favorites) can be seen ⛰️
* People who interacted with you can be navigated to

## 👩🏽‍💻 End Users: Install

To use it, you just want to [download 1.9.1 here](https://github.com/chucker/Mastonaut/releases/download/app-1.9.1/Mastonaut-1.9.1.zip).

## 🗺️ Roadmap

This is purely a hobbyist effort, so I can't really promise anything. I try to do a new release every month or two.

## 👩🏻‍🌾 Developers: Build

These are instructions for if you want to tinker with the code.

The following instructions assume Xcode 14.2 on macOS 13.4. (Note that [it may
not currently build in Xcode 14.3.x.](https://github.com/chucker/Mastonaut/issues/123))

### Setup

- You need [XcodeGen](https://github.com/yonaskolb/XcodeGen). If you have HomeBrew, just run `brew install xcodegen`.

- Inside the `Mastonaut` subdir, run `xcodegen`.

- Copy the file `userspecific.template.xcconfig` to `userspecific.xcconfig`,
and open that file.

- Set `MASTONAUT_BUNDLE_ID_BASE` to a bundle ID for the app that works with
your Apple ID.

- Enter your Team ID instead of the `xxxxxxxxxx` next to `DEVELOPMENT_TEAM` (It
looks something like `74J34U3R6X`).

- **Do not check in your changes to `userspecific.xcconfig`!**

That should be it.

### Bundle IDs

The bundle ID _base_ is used because Mastonaut consists of multiple projects,
which use an app group to share information. Given a `MASTONAUT_BUNDLE_ID_BASE`
of `com.example.mastonaut` and a `DEVELOPMENT_TEAM` of `ABCDEFGH`:

- the main app will be `com.example.mastonaut.mac`
- the macOS Sharing extension will be `com.example.mastonaut.mac.QuickToot`
- the Core Data database shared by the two above will be stored in
`~/Library/Group Containers/ABCDEFGH.com.example.mastonaut/Mastonaut/Mastonaut.sqlite`
- Keychain credentials will be prefixed `ABCDEFGH.com.example.mastonaut.keychain`

### Acknowledgments

The acknowledgments in the about box are currently built manually. If you add
dependencies, don't forget to edit one of the `*Acknowledgments` structs,
probably `SwiftPMAcknowledgements`.

### Pitfalls

- Make sure `MastodonKit` is fetched _as a git submodule_. (For example,
Xcode's git clone functionality seems to not do this!) This is a custom fork,
not a package available through SwiftPM or similar.

- The `.xcconfig` will auto-append `.mac` and other suffixes to the
`MASTONAUT_BUNDLE_ID_BASE`, so you should pick something like
`com.example.mastonaut` (replacing `com.example` with whatever reverse domain
name you have set up for your account).

- If you don't know your Team ID, go into _Signing & Capabilities_ in your
project and select your team, then your UI will show it under 'App Groups'.
Then revert the project file so it will use the setting from the `xcconfig` and
you don't have a lurking change in your checkout.

### Project Structure

The project you'll be working with is `Mastonaut/Mastonaut.xcodeproj`. Keep in
mind this is effectively read-only: to preserve changes (other than, say,
adding files, which works through wildcards), you need to edit the
`Mastonaut/project.yml` instead.

The main application is **Mastonaut**.

**QuickToot** is a macOS app extension, specifically for sharing.

QuickToot and Mastonaut use **CoreTootin** as a common library. GUI code that's
required by both belongs here.

The underlying API client is largely implemented in (a custom fork of)
**MastodonKit**, which is referenced as a git submodule.

- If you're using a personal developer ID and get an error like `Personal
development teams, including "Your Name Here", do not support the Push
Notifications capability.`, you may have to go _Signing and Capabilities_ and
delete the "Push Notifications" capability by clicking the little
trash can next to it. **Do not check in this change.**

### Working on the Help

MastonautHelp uses https://github.com/chuckhoupt/jekyll-apple-help. Each page is authored in Markdown with some [Front Matter](https://jekyllrb.com/docs/front-matter/) metadata written in YAML.

When working on changes to the help, it's easiest to run:

```sh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3
cd MastonautHelp
jekyll serve --livereload
```

This will launch a web server with live reload capability. Open that in your browser, and saving one of the help files will cause the browser to refresh.
