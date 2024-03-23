//
//  ArrangeColumnsViewController.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 30.10.23.
//

import Foundation
import UniformTypeIdentifiers

class ArrangeColumnsWindowController: NSWindowController, NSCollectionViewDelegate, NSCollectionViewDataSource {
    @IBOutlet private unowned var collectionView: NSCollectionView!

    @IBOutlet private(set) unowned var button: NSButton!

    override var windowNibName: NSNib.Name? {
        return "ArrangeColumnsWindow"
    }

    private enum ReuseIdentifiers {
        static let item = NSUserInterfaceItemIdentifier(rawValue: "item")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(ArrangeColumnsViewItem.self,
                                forItemWithIdentifier: ReuseIdentifiers.item)

//        collectionView.registerForDraggedTypes([NSPasteboard.PasteboardType(UTType.item.identifier)])
//        collectionView.setDraggingSourceOperationMask(.move, forLocal: true)
        
        collectionView.registerForDraggedTypes([.string])
        collectionView.setDraggingSourceOperationMask(.every, forLocal: true)
        collectionView.setDraggingSourceOperationMask(.every, forLocal: false)
    }

    var columnViewControllers: [ColumnViewController]?

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        highlightItems(true, at: indexPaths)
    }

    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        highlightItems(false, at: indexPaths)
    }
    
    func highlightItems(_ highlighted: Bool, at indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            guard let item = collectionView.item(at: indexPath) as? ArrangeColumnsViewItem else { continue }
            item.setHighlighted(highlighted)
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        columnViewControllers?.count ?? 0
    }

    func collectionView(_ collectionView: NSCollectionView,
                        pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting?
    {
        print("pasteboardWriterForItemAt")
        return nil
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem
    {
        let identifier = ReuseIdentifiers.item
        let item = collectionView.makeItem(withIdentifier: identifier, for: indexPath)

        let index = indexPath.item

        guard let viewItem = item as? ArrangeColumnsViewItem,
              let columnViewControllers,
              columnViewControllers.count >= index
        else { return item }

        viewItem.set(columnViewController: columnViewControllers[index])
        
        viewItem.setHighlighted(false)

        return viewItem
    }

    func collectionView(_ collectionView: NSCollectionView, writeItemsAt indexes: IndexSet, to pasteboard: NSPasteboard) -> Bool {
        print("writeItemsAt")
        return true
    }

    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
        print("canDragItemsAt")
        return true
    }

    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, index: Int, dropOperation: NSCollectionView.DropOperation) -> Bool {
        print("acceptDrop")
        // TODO: check type

        return true
    }

    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndex proposedDropIndex: UnsafeMutablePointer<Int>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        print("validateDrop")
        return NSDragOperation.move
    }

    @IBAction func done(_ sender: Any) {
        close()
    }
}
