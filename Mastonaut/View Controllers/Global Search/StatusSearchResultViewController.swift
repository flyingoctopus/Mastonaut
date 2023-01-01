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

	@IBOutlet private unowned var avatarImageView: NSImageView!
	@IBOutlet private unowned var authorNameButton: NSButton!
	@IBOutlet private unowned var handleLabel: NSTextField!

	override func awakeFromNib()
	{
		super.awakeFromNib()

//		bioLabel.linkTextAttributes = StatusResultTableCellView.bioLinkAttributes
//		bioLabel.linkHandler = nil
	}

	func set(status: Status, instance: Instance)
	{
		authorNameButton.set(stringValue: status.authorName,
							 applyingAttributes: StatusResultTableCellView._authorLabelAttributes,
							 applyingEmojis: status.account.cacheableEmojis)

		handleLabel.stringValue = status.account.uri(in: instance)
//
//		bioLabel.set(attributedStringValue: account.attributedNote,
//					 applyingAttributes: StatusResultTableCellView.bioAttributes,
//					 applyingEmojis: account.cacheableEmojis)
	}
}
