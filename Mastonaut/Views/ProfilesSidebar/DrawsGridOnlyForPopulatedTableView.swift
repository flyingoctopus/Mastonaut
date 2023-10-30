//
//  DrawsGridOnlyForPopulatedTableView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 06.08.23.
//  Copyright © 2023 Bruno Philipe. All rights reserved.
//

import Foundation

/// Draws its grid only for cells that are populated.
///
/// https://stackoverflow.com/a/43473920
class DrawsGridOnlyForPopulatedTableView: NSTableView {
	override func drawGrid(inClipRect clipRect: NSRect) {}
}
