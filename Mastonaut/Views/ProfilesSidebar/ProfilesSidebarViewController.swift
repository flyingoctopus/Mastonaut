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
	init(statusUrl: String, purpose: SidebarMode.StatusInteractionKind,
	     client: ClientType, instance: Instance,
	     sidebarMode: SidebarMode)
	{
		sidebarModelValue = sidebarMode
		
		switch purpose
		{
		case .reblog:
			titleMode = .title("Boosted by")
		case .favorite:
			titleMode = .title("Favorited by")
		}
		
		self.client = client
		self.instance = instance
		
		super.init(nibName: "ProfilesSidebarViewController", bundle: .main)
		
		refresh()
	}
	
	init(profileUrl: String, relationship: SidebarMode.RelationshipKind,
	     client: ClientType, instance: Instance,
	     sidebarMode: SidebarMode)
	{
		sidebarModelValue = sidebarMode
		
		switch relationship
		{
		case .follower:
			titleMode = .title("Followed by")
		case .following:
			titleMode = .title("Following")
		}
		
		self.client = client
		self.instance = instance

		super.init(nibName: "ProfilesSidebarViewController", bundle: .main)
		
		refresh()
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()

		tableView.usesAutomaticRowHeights = true
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet private(set) var tableView: NSTableView!
	
	var profiles: [Account]?
	
	var mainResponder: NSResponder
	{
		return tableView
	}
	
	var sidebarModelValue: SidebarModel
	
	var client: MastodonKit.ClientType?
	let instance: Instance
	
	var titleMode: SidebarTitleMode
	
	func containerWindowOcclusionStateDidChange(_ occlusionState: NSWindow.OcclusionState) {}
	
	var currentFocusRegion: NSRect?
	
	func activateKeyboardNavigation(preferredFocusRegion: NSRect?) {}
	
	enum CellViewIdentifiers
	{
		static let profile = NSUserInterfaceItemIdentifier("profile")
	}
	
	func refresh()
	{
		guard let client else { return }
		
		var request: Request<[Account]>
		
		switch sidebarModelValue
		{
		case SidebarMode.profilesForStatus(let statusUrl, let purpose):
			switch purpose
			{
			case .favorite:
				request = Statuses.favouritedBy(id: statusUrl)
			case .reblog:
				request = Statuses.rebloggedBy(id: statusUrl)
			}
		
		case SidebarMode.profilesForProfile(let profileUrl, let relationship):
			switch relationship
			{
			case .follower:
				request = Accounts.followers(id: profileUrl)
			case .following:
				request = Accounts.following(id: profileUrl)
			}
			
		default:
			return
		}
		
		client.run(request)
		{
			[weak self]
			response in
			
			guard case .success(let result) = response else { return }

			self?.profiles = result.value
			
			DispatchQueue.main.async
			{
				self?.tableView.reloadData()
			}
		}
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
		return profiles?.count ?? 0
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
	{
		let _cellView = tableView.makeView(withIdentifier: CellViewIdentifiers.profile, owner: nil)

		guard let profiles,
		      profiles.count >= row,
		      let cellView = _cellView as? ProfilesSidebarCellView
		else
		{ return view }
		
		cellView.set(profile: profiles[row], instance: instance)

		return cellView
	}
	
	@IBAction func doubleClickRow(_ sender: Any)
	{
		let row = tableView.clickedRow
		
		guard let profiles,
		      profiles.count >= row,
		      let authorizedAccountProvider = view.window?.windowController as? AuthorizedAccountProviding
		else
		{ return }
		
		let profileURI = profiles[row].uri(in: instance)
		
		let profileSidebar = SidebarMode.profile(uri: profileURI)
		authorizedAccountProvider.presentInSidebar(profileSidebar)
	}
}
