//
//  ArrangeColumnsViewItem.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 30.10.23.
//

import Cocoa

class ArrangeColumnsViewItem: NSCollectionViewItem {
    @IBOutlet var box: NSBox!
    
    @IBOutlet var label: NSTextField!
    @IBOutlet var image: NSImageView!
    
    private var columnViewController: ColumnViewController?
    
    func set(columnViewController: ColumnViewController) {
        guard let label,
              let columnMode = columnViewController.modelRepresentation as? ColumnMode
        else { return }
        
        label.stringValue = columnMode.getTitle()
        image.image = columnMode.getImage()
    }
}
