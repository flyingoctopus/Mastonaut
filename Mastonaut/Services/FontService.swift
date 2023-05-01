//
//  FontService.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 01.05.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Cocoa
import CoreTootin

struct FontService {
	init(font: NSFont) {
		self.font = font
	}

	let font: NSFont

	public func authorAttributes() -> [NSAttributedString.Key: AnyObject] {
		return [
			.foregroundColor: NSColor.labelColor,
			.font: font.withWeight(weight: .semibold)!
		]
	}
	
	public func statusAttributes() -> [NSAttributedString.Key: AnyObject] {
		return [
			.foregroundColor: NSColor.labelColor,
			.font: font,
			.underlineStyle: NSNumber(value: 0) // <-- This is a hack to prevent the label's contents from shifting
			// vertically when clicked.
		]
	}
	
	public func statusLinkAttributes() -> [NSAttributedString.Key: AnyObject] {
		return [
			.foregroundColor: NSColor.safeControlTintColor,
			.font: font.withWeight(weight: .medium)!,
			.underlineStyle: NSNumber(value: 1)
		]
	}
}
