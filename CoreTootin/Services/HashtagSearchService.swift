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
		client.run(Search.search(query: query, type: .hashtags, excludeUnreviewed: true)) { result in

			guard case .success(let response) = result else {
				completion([])
				return
			}

			completion(response.value.hashtags)
		}
	}
}

extension HashtagSearchService: SuggestionTextViewSuggestionsProvider {
	public func suggestionTextView(_ textView: SuggestionTextView,
								   suggestionsForQuery query: String,
								   completion: @escaping ([Suggestion]) -> Void)
	{
		search(query: query)
		{
			(hashtags) in

			DispatchQueue.main.async
				{
					completion(hashtags.map({ HashtagSuggestion(hashtag: $0)))
				}
		}
	}
}

private class HashtagSuggestion: Suggestion {
	let text: String

	init(hashtag: Tag, instance: Instance) {
		text = hashtag.name

		// MAYBE we could add sparklines from .history here
	}
}
