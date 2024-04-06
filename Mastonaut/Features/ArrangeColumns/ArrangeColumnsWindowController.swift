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

    var getColumnViewControllers: (() -> [ColumnViewController])?
    var moveColumnViewController: ((ColumnViewController, Int) -> Void)?
    var closeColumn: ((ColumnViewController) -> Void)?

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        getColumnViewControllers?().count ?? 0
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let identifier = ReuseIdentifiers.item
        let item = collectionView.makeItem(withIdentifier: identifier, for: indexPath)

        let index = indexPath.item

        guard let viewItem = item as? ArrangeColumnsViewItem,
              let getColumnViewControllers,
              getColumnViewControllers().count >= index
        else { return item }

        viewItem.set(columnViewController: getColumnViewControllers()[index], arrangeColumnsController: self)

        return viewItem
    }

    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        return String(indexPath.item) as NSString
    }

    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        if proposedDropOperation.pointee == .on {
            proposedDropOperation.pointee = .before
        }

        return .move
    }

    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
        guard let stringResult = draggingInfo.draggingPasteboard.propertyList(forType: .string) as? String,
              let stringUtf8Data = stringResult.data(using: .utf8)
        else { return false }

        guard let item = try? JSONDecoder().decode(Int.self, from: stringUtf8Data),
              let getColumnViewControllers,
              let moveColumnViewController
        else { return false }

        let colController = getColumnViewControllers()[item]

        print("Moving \(colController) to \(indexPath.item)")

        moveColumnViewController(colController, indexPath.item)

        collectionView.reloadData()

        return true
    }
    
    func reloadData() {
        collectionView.reloadData()
    }

    @IBAction func done(_ sender: Any) {
        close()
    }
}
