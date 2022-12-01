# Preface
Mastodon’s API [allows clients](https://docs.joinmastodon.org/methods/markers/) to synchronize one “marker” each for the home and notifications timelines. The market signifies the ID of the last status (for home) or notification (for modifications) read.

That way, you can switch apps or devices, and as long as they all implement this feature (and correctly, to boot), you’ll be right where you left off.

This document aims to explore how this could work in a client.

# Reading
When launching the client or bringing it to focus if previously in the background, the client should read the position from the API. If that position is newer than the current position, the client should fetch newer toots until the toot with the ID is found, then scroll up to it. (And, equivalently, for notifications.)

# Writing
While going through the timeline, a timer should go off once a minute. It looks at the newest toot that is fully in view. It should ask the API for the marker; if the local newest visible toot is newer, it should update the marker.
