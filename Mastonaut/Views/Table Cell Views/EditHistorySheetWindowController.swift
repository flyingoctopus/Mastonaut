//
//  EditHistorySheetWindowController.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 07.01.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import CoreTootin
import Foundation
import MastodonKit

class EditHistoryViewController: NSViewController, BaseColumnViewController, SidebarPresentable,
	NSTableViewDataSource, NSTableViewDelegate
{
	var currentFocusRegion: NSRect?

	func activateKeyboardNavigation(preferredFocusRegion: NSRect?)
	{
		guard tableView.selectedRowIndexes.isEmpty,
		      let statusHistory,
		      statusHistory.isEmpty == false
		else
		{
			return
		}

		tableView.selectFirstVisibleRow()
	}

	init(status: Status?, edits: [StatusEdit]?)
	{
		self.status = status
		self.statusHistory = edits

		super.init(nibName: "EditHistorySheetWindowController", bundle: .main)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}

	func containerWindowOcclusionStateDidChange(_ occlusionState: NSWindow.OcclusionState) {}

	var mainResponder: NSResponder
	{
		return tableView
	}

	var sidebarModelValue: SidebarModel
	{
		return SidebarMode.edits(status: status, edits: statusHistory)
	}

	var client: MastodonKit.ClientType?

	var titleMode: SidebarTitleMode
	{
		return .title(🔠("Edits"))
	}

	@IBOutlet private(set) var tableView: NSTableView!

	var status: Status?
	var statusHistory: [StatusEdit]? = []

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

	override func viewDidLoad()
	{
		super.viewDidLoad()

		tableView.register(NSNib(nibNamed: "EditedStatusTableCellView", bundle: .main),
		                   forIdentifier: CellViewIdentifiers.editedStatus)
	}

	// MARK: - Table View Data Source

	func numberOfRows(in tableView: NSTableView) -> Int
	{
		guard let statusHistory else { return 0 }

		return statusHistory.count
	}

//	func tableView(
//		_ tableView: NSTableView,
//		objectValueFor tableColumn: NSTableColumn?,
//		row: Int
//	) -> Any?
//	{
//		guard let statusHistory else { return nil }
//
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
		      let statusHistory,
		      statusHistory.count > row
		else
		{
			return view
		}

		let currentEdit = statusHistory[row]
		let previousEdit = row < statusHistory.count - 1 ? statusHistory[row + 1] : nil

		cellView.set(displayedStatusEdit: statusHistory[row], previousStatusEdit: previousEdit)

		return cellView
	}
}
