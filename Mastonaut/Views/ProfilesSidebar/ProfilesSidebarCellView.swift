//
//  ProfilesSidebarCellView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 05.08.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation

class ProfilesSidebarCellView: NSTableCellView
{
	override func awakeFromNib()
	{
		super.awakeFromNib()
	}

	@IBOutlet var bioLabel: AttributedLabel!

	func set(title: String)
	{
		bioLabel.stringValue = title
	}
}
