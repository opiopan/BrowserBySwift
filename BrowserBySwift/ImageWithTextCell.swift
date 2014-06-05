//
//  imageWithTextCell.swift
//  BrowserBySwift
//
//  Created by opiopan on 2014/06/07.
//  Copyright (c) 2014年 opiopan. All rights reserved.
//

import Cocoa

class ImageWithTextCell : NSTextFieldCell {
    override func drawInteriorWithFrame(cellFrame: NSRect, inView controlView: NSView!){
        // Retrieving image and text of associated object
        let node:AnyObject = self.objectValue
        let image:NSImage = node.valueForKey("icon") as NSImage
        let name:NSString = node.valueForKey("name") as NSString
        
        controlView.lockFocus()

        // Drawing image
        var target = cellFrame
        target.size.width = target.size.height;
        image.drawInRect(target, fromRect:NSZeroRect, operation:NSCompositingOperation.CompositeSourceOver,
                         fraction:1.0, respectFlipped:true, hints:nil)

        // Drawing text
        var p2:NSPoint = cellFrame.origin;
        p2.x += cellFrame.size.height + 4.0;
        p2.y += 0.0;
        let attrs:NSDictionary = self.attributedStringValue.attributesAtIndex(0, effectiveRange:nil)
        name.drawAtPoint(p2, withAttributes:attrs)
        
        controlView.unlockFocus()
    }
}
