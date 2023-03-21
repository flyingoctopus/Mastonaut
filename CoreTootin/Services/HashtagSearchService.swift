//
//  HashtagSearchService.swift
//  CoreTootin
//
//  Created by Sören Kuklau on 19.03.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation
import MastodonKit

public class HashtagSearchService {
	private let client: ClientType

	public init(client: ClientType) {
		self.client = client
	}

	public func search(query: String, completion: @escaping ([Tag]) -> Void) {
		let _query = query.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
		
		client.run(Search.search(query: _query, type: .hashtags, excludeUnreviewed: false)) { result in

			guard case .success(let response) = result else {
				completion([])
				return
			}

			completion(response.value.hashtags)
		}
	}
}

extension HashtagSearchService: HashtagSuggestionTextViewSuggestionsProvider {
	public func suggestionTextView(_ textView: SuggestionTextView,
								   suggestionsForQuery query: String,
								   completion: @escaping ([HashtagSuggestionProtocol]) -> Void) 
	{
		search(query: query) {
			hashtags in

			DispatchQueue.main.async {
				completion(hashtags.map { HashtagSuggestion(hashtag: $0) })
			}
		}
	}
}

@objc public protocol HashtagSuggestionProtocol {
	var text: String { get }
}

private class HashtagSuggestion: HashtagSuggestionProtocol {
	let text: String

	init(hashtag: Tag) {
		text = hashtag.name

		// MAYBE we could add sparklines from .history here
	}
}
