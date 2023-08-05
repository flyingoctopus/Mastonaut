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
	init(title: String, profiles: [String]) {
		self.sidebarTitle = title
		self.profiles = profiles
		
		super.init(nibName: "ProfilesSidebarViewController", bundle: .main)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet private(set) var tableView: NSTableView!
	
	let sidebarTitle: String
	let profiles: [String]
	
	var mainResponder: NSResponder
	{
		return tableView
	}
	
	var sidebarModelValue: SidebarModel {
		return SidebarMode.profiles(title: sidebarTitle, profileURIs: profiles)
	}
	
	var client: MastodonKit.ClientType?
	
	var titleMode: SidebarTitleMode {
		return .title(🔠(sidebarTitle))
	}
	
	func containerWindowOcclusionStateDidChange(_ occlusionState: NSWindow.OcclusionState) {}
	
	var currentFocusRegion: NSRect?
	
	func activateKeyboardNavigation(preferredFocusRegion: NSRect?) {}
}
