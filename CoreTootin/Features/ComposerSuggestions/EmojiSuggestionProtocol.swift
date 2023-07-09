//
//  Protocols.swift
//  CoreTootin
//
//  Created by Sören Kuklau on 09.07.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation

@objc public protocol EmojiSuggestionProtocol {
	var imageUrl: URL? { get }
	var shortcode: String { get }
	
	func fetchImage(completion: @escaping (Data?) -> Void)
}
