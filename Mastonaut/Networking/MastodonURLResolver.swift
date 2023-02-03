//
//  MastodonURLResolver.swift
//  Mastonaut
//
//  Created by Bruno Philipe on 09.04.19.
//  Mastonaut - Mastodon Client for Mac
//  Copyright © 2019 Bruno Philipe.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import CoreTootin
import Foundation
import MastodonKit

struct MastodonURLResolver {
	static func resolve(using client: ClientType?, url: URL, knownTags: [Tag]?, source windowController: TimelinesWindowController?)
	{
		if let mode = getSidebarModeFromAnnotations(url: url, knownTags: knownTags), let windowController = windowController
		{
			windowController.presentInSidebar(mode)
		}
		else if let client, let status = fetchStatusFromUrl(using: client, url: url) {
			windowController?.presentInSidebar(SidebarMode.status(uri: url.absoluteString, status: status))
		}
		else {
			NSWorkspace.shared.open(url)
		}
	}
	
	private static func getSidebarModeFromAnnotations(url: URL, knownTags: [Tag]?) -> SidebarMode? {
		var modeToPresent: SidebarMode?
		
		if let annotations = (url as? AnnotatedURL)?.annotation?.split(separator: " ") {
			if annotations.contains("mention") {
				if annotations.contains("u-url") {
					modeToPresent = .profile(uri: url.mastodonHandleFromAccountURI)
				}
				else if annotations.contains("hashtag") {
					if let tag = knownTags?.first(where: { $0.url == url }) {
						modeToPresent = .tag(tag.name)
					}
					else if let leadIndex = url.pathComponents.firstIndex(where: { $0 == "tag" || $0 == "tags" }),
					        leadIndex < url.pathComponents.count
					{
						modeToPresent = .tag(url.pathComponents[leadIndex + 1])
					}
				}
			}
		}
		
		return modeToPresent
	}
	
	private static func fetchStatusFromUrl(using client: ClientType, url: URL) async throws -> Status? {
		/*
		 * TODO: make this a `StatusResolver` that also handles
		 * StatusThreadViewController.resolveStatus, which is
		 * different in that here, we're merely _guessing_ that
		 * a URL might point to a status, but that method _expects_
		 * a status
		 */
		
		var cancel = false

		let uri = url.absoluteString
		
		var status: Status?
		
		try await withThrowingTaskGroup(of: Status?.self) {
			group in
			
			group.addTask {
				client.run(Search.search(query: uri, limit: 1, resolve: true)) {
					result in

					if case .success(let searchResults, _) = result, let firstResult = searchResults.statuses.first
					{
						status = firstResult
					}
				}
			}
			
			group.addTask {
				try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
				return nil
			}
			
			let _ = try await group.next()
			group.cancelAll()
		}
		
		return status
	}
}
