//
//  EditedStatusTableCellView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 07.01.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import CoreTootin
import Foundation
import MastodonKit
import Sdifft

class EditedStatusTableCellView: NSTableCellView {
	@IBOutlet private unowned var statusLabel: AttributedLabel!

	@IBOutlet var contentWarningContainer: BorderView!
	@IBOutlet var contentWarningLabel: AttributedLabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	@objc internal private(set) dynamic
	var cellModel: StatusEditCellModel?
	
	func set(displayedStatusEdit statusEdit: StatusEdit, previousStatusEdit: StatusEdit?) {
		let cellModel = StatusEditCellModel(statusEdit: statusEdit)
		self.cellModel = cellModel
		
		contentWarningContainer.isHidden = true
		
		// https://github.com/chucker/Mastonaut/issues/79 unclear why needed (otherwise set to pink)
		contentWarningLabel.backgroundColor = NSColor.clear
		statusLabel.backgroundColor = NSColor.clear

		if let previousStatusEdit {
			let previousContent = previousStatusEdit.attributedContent.string
			let content = statusEdit.attributedContent.string
			
			statusLabel.attributedStringValue = NSAttributedString(source: previousContent,
			                                                       target: content,
			                                                       attributes: EditedStatusTableCellView._diffAttributes)
		}
		else {
			statusLabel.stringValue = statusEdit.attributedContent.string
		}
		
//		statusLabel.set(attributedStringValue: statusEdit.content,
//						applyingAttributes: _statusLabelAttributes
//						applyingEmojis: nil) // TODO
	}
	
	private static let _diffAttributes: DiffAttributes =
		.init(
			insert: [.backgroundColor: NSColor.green],
			delete: [.backgroundColor: NSColor.red],
			same: [.backgroundColor: NSColor.white]
		)
	
	private static let _statusLabelAttributes: [NSAttributedString.Key: AnyObject] = [
		.foregroundColor: NSColor.labelColor, .font: NSFont.labelFont(ofSize: 14),
		.underlineStyle: NSNumber(value: 0) // <-- This is a hack to prevent the label's contents from shifting
		// vertically when clicked.
	]
}
