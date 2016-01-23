//
//  ScrollViewWithHeader.swift
//  NotDoingList
//
//  Created by Satendra Dagar on 18/01/16.
//  Copyright © 2016 STAY REAL. All rights reserved.
//
import Cocoa

let REFRESH_HEADER_HEIGHT:CGFloat = 300.0
let Throating_Limit:CGFloat = 30.0

class ScrollViewWithHeader: NSScrollView {

    var refreshHeader:NSView!
    var isRefreshingNow:Bool!
    var progress:NSProgressIndicator!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createHeaderView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector.init("viewBoundsChanged:") , name: NSViewBoundsDidChangeNotification, object: self.contentView);
        self.hasVerticalRuler = false
        self.hasVerticalScroller = false
        self.hasHorizontalScroller = false
        self.hasHorizontalRuler = false
        self.verticalScroller = nil
        self.rulersVisible = false
        self.verticalLineScroll = 0.0
        isRefreshingNow = false
        
        let panGesture :NSPanGestureRecognizer = NSPanGestureRecognizer.init(target: self, action: Selector.init("recognizerDidFire:"))
        self.superview!.addGestureRecognizer(panGesture)
    }
    
    func createHeaderView(){
        // Add header view to clipview
        let contentRect:NSRect = self.contentView.documentView!.frame;
        self.wantsLayer = true
        refreshHeader = NSView.init(frame: NSMakeRect(0,
            0.0 - REFRESH_HEADER_HEIGHT, //contentRect.origin.y+contentRect.size.height,
            contentRect.size.width,
            REFRESH_HEADER_HEIGHT))
        refreshHeader.wantsLayer = true
        refreshHeader.layer?.backgroundColor = NSColor.redColor().CGColor
        self.contentView.addSubview(refreshHeader)
        let imageView = NSImageView.init(frame: NSRect.init(x: 0, y: 60, width: contentRect.size.width, height: REFRESH_HEADER_HEIGHT - 60))
        imageView.image = NSImage.init(named: "large-image")
        refreshHeader.addSubview(imageView)

    }
    
    func viewBoundsChanged(notification:NSNotification) -> Void{
        
        if (true ==  isRefreshingNow ){
            let scrollValue:CGFloat = bounds.origin.y;
//            Swift.print(scrollValue);  // show how far user has scrolled
            return
        }
        
        let isOver = self.overRefreshView()
        Swift.print("viewBoundsChanged:\(isOver)");
        if isOver {
            
            self.startContentLoading()
            
        }
        else{
            
        }
    }
    
    func startContentLoading(){
    
        //SS Load any api data etc from other thread
        if isRefreshingNow == true{
            
            return;
        }
        
        isRefreshingNow = true
        self.contentInsets = NSEdgeInsetsMake(300, 0, 0, 0);
//        self.contentView.scrollPoint(NSPoint.init(x: 0, y: -248))
        progress = NSProgressIndicator.init(frame: NSRect.init(x: 225, y: 10, width: 30, height: refreshHeader.frame.size.height))
        progress.style = .SpinningStyle
        progress.startAnimation(nil)
        refreshHeader.addSubview(progress)
        progress.sizeToFit()
        NSAnimationContext.beginGrouping()
        NSAnimationContext.currentContext().duration = 0.5
        let clipView:NSClipView = self.contentView
        var newOrigin:NSPoint = clipView.bounds.origin;
        newOrigin.y = -270;
        clipView.animator().bounds.origin = newOrigin
        NSAnimationContext.endGrouping()
        
    self.performSelector(Selector.init("finishContentLoading"), withObject: nil, afterDelay: 3.0)
    }
    
    func finishContentLoading(){

        if isRefreshingNow == false{
            return;
        }
        
        isRefreshingNow = false
        progress.removeFromSuperview()
        progress = nil
        
        self.contentInsets = NSEdgeInsetsMake(0, 0, 0, 0);

    }
    
    func minimumScroll() -> CGFloat{
        
        return (0 - Throating_Limit);
        
    }
    
    func overRefreshView() -> Bool{
        let clipView:NSClipView = self.contentView;
        let bounds:NSRect = clipView.bounds;
    
        let scrollValue:CGFloat = bounds.origin.y;
        let minimumScroll:CGFloat = self.minimumScroll();
    	Swift.print(scrollValue);  // show how far user has scrolled
    return (scrollValue <= minimumScroll);
        
    }

    func restoreOverRefresh(){
        
        let previousTop = self.contentInsets.top
        Swift.print(previousTop)
        if previousTop == 300 {
            
                self.finishContentLoading()
            
        }
    }
    
    @IBAction func recognizerDidFire(sender: NSPanGestureRecognizer) {
        
        Swift.print("Transition:\(sender.translationInView(self))")
        
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        
        Swift.print("scrollingDeltaY:\(theEvent.timestamp)")
        
//        if theEvent.phase
//        {
//            // theEvent is generated by trackpad
//        }
//        else
//        {
//            // theEvent is generated by mouse
//        }
//    }
        super.scrollWheel(theEvent)
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("Dragged\(theEvent)")
//        _: NSPoint = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        self.autoscroll(theEvent)

    }

}


