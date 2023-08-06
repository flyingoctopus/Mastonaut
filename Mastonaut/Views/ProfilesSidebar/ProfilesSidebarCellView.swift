//
//  ProfilesSidebarCellView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 05.08.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation
import MastodonKit

class ProfilesSidebarCellView: NSTableCellView
{
	override func awakeFromNib()
	{
		super.awakeFromNib()
	}

	@IBOutlet weak var userDisplayNameButton: NSButton!
	@IBOutlet private unowned var agentAvatarButton: NSButton!
	@IBOutlet private unowned var userAccountLabel: NSTextField!
	@IBOutlet private unowned var userBioLabel: AttributedLabel!

	func set(profile: Account, instance: Instance)
	{
		userDisplayNameButton.title = profile.bestDisplayName
		userAccountLabel.stringValue = profile.uri(in: instance)
		userBioLabel.attributedStringValue = profile.attributedNote
		
		userBioLabel.backgroundColor = NSColor.clear
		
		AppDelegate.shared.avatarImageCache.fetchImage(account: profile)
		{ [weak self] result in

			DispatchQueue.main.async
			{
				switch result
				{
				case .inCache(let avatarImage), .loaded(let avatarImage):
					self?.agentAvatarButton.image = avatarImage
				case .noImage:
					self?.agentAvatarButton.image = #imageLiteral(resourceName: "missing")
				}
			}
		}
	}
}
