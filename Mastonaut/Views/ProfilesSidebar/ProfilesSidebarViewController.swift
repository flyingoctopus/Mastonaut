//
//  ProfilesSidebarViewController.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 05.08.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import CoreTootin
import Foundation
import MastodonKit

class ProfilesSidebarViewController: NSViewController,
	NSTableViewDataSource, NSTableViewDelegate, SidebarPresentable
{
	init(title: String, profiles: [String])
	{
		self.sidebarTitle = title
		self.profiles = profiles
		
		super.init(nibName: "ProfilesSidebarViewController", bundle: .main)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet private(set) var tableView: NSTableView!
	
	let sidebarTitle: String
	let profiles: [String]
	
	var mainResponder: NSResponder
	{
		return tableView
	}
	
	var sidebarModelValue: SidebarModel
	{
		return SidebarMode.profiles(title: sidebarTitle, profileURIs: profiles)
	}
	
	var client: MastodonKit.ClientType?
	
	var titleMode: SidebarTitleMode
	{
		return .title(🔠(sidebarTitle))
	}
	
	func containerWindowOcclusionStateDidChange(_ occlusionState: NSWindow.OcclusionState) {}
	
	var currentFocusRegion: NSRect?
	
	func activateKeyboardNavigation(preferredFocusRegion: NSRect?) {}
	
	enum CellViewIdentifiers
	{
		static let profile = NSUserInterfaceItemIdentifier("profile")
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		tableView.register(NSNib(nibNamed: "ProfilesSidebarCellView", bundle: .main),
		                   forIdentifier: CellViewIdentifiers.profile)
	}
	
	// MARK: - Table View Data Source

	func numberOfRows(in tableView: NSTableView) -> Int
	{
		return profiles.count
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
	{
		let _cellView = tableView.makeView(withIdentifier: CellViewIdentifiers.profile, owner: nil)

		guard let cellView = _cellView as? ProfilesSidebarCellView
		else
		{ return view }
		
		cellView.set(title: "hello")

		return cellView
	}
}
