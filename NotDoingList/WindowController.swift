//
//  WindowController.swift
//  NotDoingList
//
//  Created by Harry Ng on 16/1/2016.
//  Copyright © 2016 STAY REAL. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func addItem(sender: NSToolbarItem) {
        if let vc = contentViewController as? ViewController {
            vc.addItem()
        }
    }
    
}
