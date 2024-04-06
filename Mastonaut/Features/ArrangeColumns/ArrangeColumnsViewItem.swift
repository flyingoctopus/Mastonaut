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
    
    private var arrangeColumnsController: ArrangeColumnsWindowController?
    
    func set(columnViewController: ColumnViewController, arrangeColumnsController: ArrangeColumnsWindowController) {
        guard let label,
              let columnMode = columnViewController.modelRepresentation as? ColumnMode
        else { return }
        
        self.columnViewController = columnViewController
        self.arrangeColumnsController = arrangeColumnsController
        
        label.stringValue = columnMode.getTitle()
        image.image = columnMode.getImage()
    }
    
    @IBAction func closeColumn(_ sender: Any) {
        guard let columnViewController,
              let closeColumn = arrangeColumnsController?.closeColumn
        else { return }
        
        closeColumn(columnViewController)
    }
}
