//
//  ScrollViewWithHeader.swift
//  NotDoingList
//
//  Created by Satendra Dagar on 18/01/16.
//  Copyright © 2016 STAY REAL. All rights reserved.
//
import Cocoa

//#define REFRESH_HEADER_HEIGHT 52

class ScrollViewWithHeader: NSScrollView {

    var refreshHeader:NSView!
    var isRefreshingNow:Bool!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createHeaderView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector.init("viewBoundsChanged:") , name: NSViewBoundsDidChangeNotification, object: self.contentView);
        isRefreshingNow = false
    }
    
    func createHeaderView(){
        // Add header view to clipview
        let contentRect:NSRect = self.contentView.documentView!.frame;
        self.wantsLayer = true
        refreshHeader = NSView.init(frame: NSMakeRect(0,
            0 - 100, //contentRect.origin.y+contentRect.size.height,
            contentRect.size.width,
            52))
        refreshHeader.wantsLayer = true
        refreshHeader.layer?.backgroundColor = NSColor.redColor().CGColor
        self.contentView.addSubview(refreshHeader)
    }
    
    func viewBoundsChanged(notification:NSNotification) -> Void{
        
        if (true ==  isRefreshingNow ){
            return
        }
        
        let isOver = self.overRefreshView()
        Swift.print("viewBoundsChanged:\(isOver)");
//        if isOver {
//            self.contentInsets = NSEdgeInsetsMake(refreshHeader.frame.size.height, 0, 0, 0);
//            isRefreshingNow = true
//        }
//        else{
//            self.contentInsets = NSEdgeInsetsMake(0, 0, 0, 0);
//   
//        }
    }
    
    func minimumScroll() -> CGFloat{
        
        return (0 - refreshHeader.frame.size.height);
        
    }
    
    func overRefreshView() -> Bool{
        let clipView:NSClipView = self.contentView;
        let bounds:NSRect = clipView.bounds;
    
        let scrollValue:CGFloat = bounds.origin.y;
        let minimumScroll:CGFloat = self.minimumScroll();
    	Swift.print(scrollValue);  // show how far user has scrolled
    return (scrollValue <= minimumScroll);
    }

}


