//
//  EditedStatusTableCellView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 07.01.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation
import MastodonKit

class EditedStatusTableCellView: NSTableCellView {
	@IBOutlet private unowned var statusLabel: AttributedLabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	@objc internal private(set) dynamic
	var cellModel: StatusEditCellModel?
	
	func set(displayedStatusEdit statusEdit: StatusEdit) {
		statusLabel.stringValue = "howdy"
		
		let cellModel = StatusEditCellModel(statusEdit: statusEdit)
		self.cellModel = cellModel
	}
}
