//
//  ViewController.swift
//  NotDoingList
//
//  Created by Harry Ng on 16/1/2016.
//  Copyright © 2016 STAY REAL. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var collectionScrollView: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.redColor().CGColor
        collectionScrollView.verticalScrollElasticity = NSScrollElasticity.init(rawValue: 2)!
        collectionScrollView.hasVerticalScroller = false

//        collectionScrollView.contentInsets = NSEdgeInsetsMake(100, 0, 0, 0);
        collectionView.backgroundColors = [NSColor.clearColor()]
    }
    
    func addItem() {
        // Add Item
    }

}

extension ViewController: NSCollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItemWithIdentifier("NotDoingItem", forIndexPath: indexPath)
        
        item.textField?.stringValue = "Not Doing List \(indexPath.item)"
        
        return item
    }
}

extension ViewController: NSCollectionViewDelegate {
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        print(indexPaths)
    }
    
}

extension ViewController: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        return NSSize(width: collectionView.bounds.width, height: 50)
    }
    
}
