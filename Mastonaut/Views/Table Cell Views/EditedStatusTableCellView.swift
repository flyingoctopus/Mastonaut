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
	
	func set(displayedStatusEdit: StatusEdit) {
		statusLabel.stringValue = "howdy"
	}
}
