//
//  CustomEmojiSearchService.swift
//  CoreTootin
//
//  Created by Sören Kuklau on 09.07.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Cocoa
import CoreTootin
import MastodonKit

class EmojiSearchService {
    private let customEmoji: [CacheableEmoji]
    private let customEmojiCache: CustomEmojiCache

    /// _Some_ built-in (Unicode) emoji. Grapheme clusters aren't
    /// really implemented here.
    lazy var unicodeEmoji: [String: UnicodeScalar] = {
        var map = [String: UnicodeScalar]()

        // https://developer.apple.com/forums/thread/110059?answerId=337004022#337004022
        let emojiRanges = [
            0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map

            // not useful without grapheme cluster support
            // 0x1F1E6...0x1F1FF, // Regional country flags

            0x2600...0x26FF, // Misc symbols 9728 - 9983
            0x2700...0x27BF, // Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs 129280 - 129535
            0x1F018...0x1F270, // Various asian characters           127000...127600
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447
        ]

        for range in emojiRanges {
            for i in range {
                if let scalar = UnicodeScalar(i),
                   let description = scalar.properties.name?.lowercased()
                {
                    map[description] = scalar
                }
            }
        }

        return map
    }()

    public init(customEmoji: [CacheableEmoji]) {
        self.customEmoji = customEmoji

        customEmojiCache = AppDelegate.shared.customEmojiCache
    }

    public func search(query: String, completion: @escaping ([EmojiSuggestionProtocol]) -> Void) {
        let _query = query.trimmingCharacters(in: CharacterSet(charactersIn: ":"))

        let unicodeResults = unicodeEmoji.filter { $0.key.range(of: _query, options: .caseInsensitive) != nil }.map { UnicodeEmojiSuggestion(scalar: $0.value) }

        let customResults = customEmoji.filter { $0.shortcode.range(of: _query, options: .caseInsensitive) != nil }.map { CustomEmojiSuggestion(emoji: $0) }

        var results = [EmojiSuggestionProtocol]()

        results.append(contentsOf: unicodeResults)
        results.append(contentsOf: customResults)

        results.sort { $0.text < $1.text }

        completion(results)
    }
}

extension EmojiSearchService: SuggestionTextViewSuggestionsProvider {
    public func suggestionTextView(_ textView: SuggestionTextView, suggestionsForQuery query: String, completion: @escaping (Any) -> Void) {
        search(query: query) {
            results in

            completion(results.map { SuggestionContainer.emoji($0) })
        }
    }
}

private class UnicodeEmojiSuggestion: EmojiSuggestionProtocol {
    func getReplacement() -> String {
        return "\(emoji) "
    }

    let scalar: UnicodeScalar
    var text: String
    var emoji: String {
        scalar.description
    }

    init(scalar: UnicodeScalar) {
        self.scalar = scalar
        text = scalar.properties.name!.lowercased()
    }

    func fetchImage(completion: @escaping (NSImage?) -> Void) {
        let attributes = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 14)]
        let mutableString = NSMutableAttributedString(string: emoji, attributes: attributes)
        let size = mutableString.size()
        // emoji gets cut off otherwise, as of macOS 13.5
        let sizeWithPadding = NSSize(width: size.width,
                                     height: size.height + 2)
        let image = NSImage(size: sizeWithPadding)
        image.lockFocus()
        mutableString.draw(in: NSRect(origin: .zero,
                                      size: size))
        image.unlockFocus()

        completion(image)
    }
}

private class CustomEmojiSuggestion: EmojiSuggestionProtocol {
    let imageUrl: URL?
    var text: String

    init(emoji: CacheableEmoji) {
        imageUrl = emoji.url
        text = emoji.shortcode
    }

    func fetchImage(completion: @escaping (NSImage?) -> Void) {
        if let imageUrl {
            AppDelegate.shared.customEmojiCache.cachedEmoji(with: imageUrl, fetchIfNeeded: true) {
                data in

                if let data, !data.isEmpty {
                    completion(NSImage(data: data))
                }
                else {
                    completion(nil)
                }
            }
        }
    }

    func getReplacement() -> String {
        return ":\(text): "
    }
}
