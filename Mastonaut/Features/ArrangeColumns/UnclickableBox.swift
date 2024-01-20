//
//  UnclickableBoxView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 04.11.23.
//

import Foundation

class UnclickableBox: NSBox {
    override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
}
