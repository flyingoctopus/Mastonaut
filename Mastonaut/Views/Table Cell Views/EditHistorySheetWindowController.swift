//
//  EditHistorySheetWindowController.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 07.01.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation
import MastodonKit

class EditHistorySheetWindowController: NSWindowController, NSTableViewDataSource, NSTableViewDelegate
{
	@IBOutlet private(set) var tableView: NSTableView!

	override var windowNibName: NSNib.Name?
	{
		return "EditHistorySheetWindowController"
	}

	public var statusHistory: [StatusEdit] = []

//	public convenience init(history: [StatusEdit])
//	{
//		self.statusHistory = history
//
//		self.init(windowNibName: NSNib.Name("EditHistorySheetWindowController"))
//	}

	enum CellViewIdentifiers
	{
		static let editedStatus = NSUserInterfaceItemIdentifier("editedStatus")
	}

	override func windowDidLoad()
	{
		super.windowDidLoad()

		tableView.register(NSNib(nibNamed: "EditedStatusTableCellView", bundle: .main),
		                   forIdentifier: CellViewIdentifiers.editedStatus)
	}

	// MARK: - Table View Data Source

	func numberOfRows(in tableView: NSTableView) -> Int
	{
		return statusHistory.count
	}

//	func tableView(
//		_ tableView: NSTableView,
//		objectValueFor tableColumn: NSTableColumn?,
//		row: Int
//	) -> Any?
//	{
//		return statusHistory[row]
//	}

//	func tableView(
//		_ tableView: NSTableView,
//		rowViewForRow row: Int
//	) -> NSTableRowView?
//	{
//		return nil
//	}

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
	{
		let view = tableView.makeView(withIdentifier: CellViewIdentifiers.editedStatus, owner: nil)

		guard let cellView = view as? EditedStatusTableCellView,
			  statusHistory.count > row
		else
		{
			return view
		}

		cellView.set(displayedStatusEdit: statusHistory[row])

		return cellView
	}
}
