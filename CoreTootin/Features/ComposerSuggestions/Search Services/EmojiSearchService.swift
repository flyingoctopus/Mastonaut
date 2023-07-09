//
//  CustomEmojiSearchService.swift
//  CoreTootin
//
//  Created by Sören Kuklau on 09.07.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import CoreTootin
import Foundation
import MastodonKit

class EmojiSearchService {
	private let customEmoji: [CacheableEmoji]
	private let customEmojiCache: CustomEmojiCache

	public init(customEmoji: [CacheableEmoji]) {
		self.customEmoji = customEmoji

		customEmojiCache = AppDelegate.shared.customEmojiCache
	}

	public func search(query: String, completion: @escaping ([CacheableEmoji]) -> Void) {
		let _query = query.trimmingCharacters(in: CharacterSet(charactersIn: ":"))

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

		completion(customEmoji.filter { $0.shortcode.range(of: _query, options: .caseInsensitive) != nil })
	}
}

extension EmojiSearchService: SuggestionTextViewSuggestionsProvider {
	public func suggestionTextView(_ textView: SuggestionTextView, suggestionsForQuery query: String, completion: @escaping (Any) -> Void) {
		search(query: query) {
			results in

//			let renderedImages = [EmojiSuggestionProtocol]
//
//			for customEmoji in results {
//				AppDelegate.shared.customEmojiCache.cachedEmoji(with: customEmoji.url, fetchIfNeeded: true) {
//
//				}
//			}
//

			let result = results.map {
				SuggestionContainer.emoji(EmojiSuggestion(emoji: $0))
			}

			completion(result)
		}
	}
}

private class EmojiSuggestion: EmojiSuggestionProtocol {
	let imageUrl: URL?
	var shortcode: String

	init(emoji: CacheableEmoji) {
		imageUrl = emoji.url
		shortcode = emoji.shortcode
	}

	func fetchImage(completion: @escaping (Data?) -> Void) {
		if let imageUrl {
			AppDelegate.shared.customEmojiCache.cachedEmoji(with: imageUrl, fetchIfNeeded: true) {
				data in

				completion(data)
			}
		}
	}
}
