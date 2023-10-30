//
//  ArrangeColumnsViewController.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 30.10.23.
//

import Foundation

class ArrangeColumnsWindowController: NSWindowController, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    override var windowNibName: NSNib.Name? {
        return "ArrangeColumnsWindow"
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
//        for i in 1..<10 {
            ArrangeColumnsViewItem()
//        }
    }
    
    @IBAction func done(_ sender: Any) {
        close()
    }
}
