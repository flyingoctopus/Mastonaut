//
//  CustomEmojiSearchService.swift
//  CoreTootin
//
//  Created by Sören Kuklau on 09.07.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation
import MastodonKit
import CoreTootin

public class EmojiSearchService {
	private let emojiCache: [CacheableEmoji]

	public init(activeInstance: Instance) {
		let baseDomain = activeInstance.uri
		
		emojiCache = AppDelegate.shared.customEmojiCache.cachedEmoji(forInstance: baseDomain)
	}

	public func search(query: String, completion: @escaping ([Emoji]) -> Void) {
//		client.run(Accounts.search(query: query))
//		{ result in
//			guard case .success(let response) = result
//			else
//			{
//				completion([])
//				return
//			}
//
//			completion(response.value)
//		}
	}
}

extension EmojiSearchService: SuggestionTextViewSuggestionsProvider {
	public func suggestionTextView(_ textView: SuggestionTextView, suggestionsForQuery query: String, completion: @escaping (Any) -> Void) {
		search(query: query) {
			_ in
		}
	}
}
