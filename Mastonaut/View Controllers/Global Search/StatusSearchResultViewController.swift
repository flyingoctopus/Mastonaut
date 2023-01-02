//
//  StatusSearchResultViewController.swift
//  Mastonaut
//
//  Created by Bruno Philipe on 02.07.19.
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

class StatusSearchResultsViewController: SearchResultsViewController<Status>
{
	@IBOutlet unowned var _tableView: NSTableView!

	private var instance: Instance!

	override var tableView: NSTableView!
	{
		return _tableView
	}

	override internal var cellIdentifier: NSUserInterfaceItemIdentifier
	{
		return NSUserInterfaceItemIdentifier("status")
	}

	override func set(results: ResultsType, instance: Instance)
	{
		self.instance = instance
		elements = results.statuses
	}

	override internal func populate(cell: NSTableCellView, for status: Status)
	{
		(cell as? StatusResultTableCellView)?.set(status: status, instance: instance)
	}

	override internal func makeSelection(for status: Status) -> SearchResultSelection
	{
		return .status(status)
	}
}

class StatusResultTableCellView: NSTableCellView
{
	/// See `StatusTableCellView`
	private static let _authorLabelAttributes: [NSAttributedString.Key: AnyObject] = [
		.foregroundColor: NSColor.labelColor, .font: NSFont.systemFont(ofSize: 14, weight: .semibold)
	]

	private static let _statusLabelAttributes: [NSAttributedString.Key: AnyObject] = [
		.foregroundColor: NSColor.labelColor, .font: NSFont.labelFont(ofSize: 14),
		.underlineStyle: NSNumber(value: 0) // <-- This is a hack to prevent the label's contents from shifting
		// vertically when clicked.
	]

//	@IBOutlet private unowned var avatarImageView: NSImageView!
	@IBOutlet private unowned var authorNameButton: NSButton!
	@IBOutlet private unowned var authorAccountLabel: NSTextField!
	@IBOutlet var statusLabel: AttributedLabel!

	@IBOutlet var contentWarningLabel: AttributedLabel!

	@IBOutlet var timestamp: RefreshingFormattedTextField!
	@IBOutlet var hasPoll: NSTextField!

	@IBOutlet var attachments: NSTextField!

	override func awakeFromNib()
	{
		super.awakeFromNib()
	}

	func set(status: Status, instance: Instance)
	{
		authorNameButton.set(stringValue: status.authorName,
		                     applyingAttributes: StatusResultTableCellView._authorLabelAttributes,
		                     applyingEmojis: status.account.cacheableEmojis)

		authorAccountLabel.stringValue = status.account.uri(in: instance)

		// TODO: CW

		var statusString: NSAttributedString

		if status.attributedContent.length > 500
		{
			let truncatedString = status.attributedContent.attributedSubstring(from: NSMakeRange(0, 100)).mutableCopy() as! NSMutableAttributedString
			truncatedString.append(NSAttributedString(string: "…"))
			statusString = truncatedString
		}
		else
		{
			statusString = status.attributedContent
		}

		statusLabel.set(attributedStringValue: statusString,
		                applyingAttributes: StatusResultTableCellView._statusLabelAttributes,
		                applyingEmojis: status.cacheableEmojis)

		if status.mediaAttachments.count > 0
		{
			attachments.isHidden = false
			attachments.stringValue = 🔠("%@ attachments", String(status.mediaAttachments.count))
		}
		else
		{
			attachments.isHidden = true
		}

		hasPoll.isHidden = status.poll == nil
	}
}
