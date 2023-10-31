//
//  ArrangeColumnsViewController.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 30.10.23.
//

import Foundation

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
    }

    var columnViewControllers: [ColumnViewController]?

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        columnViewControllers?.count ?? 0
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

        return viewItem
    }

    @IBAction func done(_ sender: Any) {
        close()
    }

    @IBAction func what(_ sender: Any) {}
}
