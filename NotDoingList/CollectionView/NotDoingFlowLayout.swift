//
//  NotDoingFlowLayout.swift
//  NotDoingList
//
//  Created by Harry Ng on 16/1/2016.
//  Copyright © 2016 STAY REAL. All rights reserved.
//

import Cocoa

class NotDoingFlowLayout: NSCollectionViewFlowLayout {

    override func shouldInvalidateLayoutForBoundsChange(newBounds: NSRect) -> Bool {
        invalidateLayout()
        return true
    }
    
}
