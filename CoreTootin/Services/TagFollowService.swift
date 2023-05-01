//
//  TagFollowService.swift
//  CoreTootin
//
//  Created by Sören Kuklau on 01.05.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation
import MastodonKit

/// This is very similar to `TagBookmarkService`. However, whereas
/// bookmarking tags is entirely a client-side feature (there's no API, as of 4.1),
/// stored in Core Data, and surfaced in the menu bar, _following_ a tag is
/// entirely server-side, stored in the API, and surfaced in your timeline.
public class TagFollowService
{
	private let account: AuthorizedAccount
	private let client: ClientType

	public init(account: AuthorizedAccount, client: ClientType)
	{
		self.account = account
		self.client = client
	}

	public func isTagFollowed(_ tag: String) -> Bool
	{
		return account.hasFollowedTag(tag, client: client)
	}

	public func followTag(_ tag: String)
	{
		account.followTag(tag, client: client)
	}

	public func unfollowTag(_ tag: String)
	{
		account.unfollowTag(tag, client: client)
	}

	public func toggleFollowedState(for tag: String)
	{
		if account.hasFollowedTag(tag, client: client)
		{
			unfollowTag(tag)
		}
		else
		{
			followTag(tag)
		}
	}
}
