//
//  Document.swift
//  BrowserBySwift
//
//  Created by opiopan on 2014/06/05.
//  Copyright (c) 2014年 opiopan. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    //-----------------------------------------------------------------------------------------
    // Properties
    //-----------------------------------------------------------------------------------------
    var root: FileNode?
    
    
    //-----------------------------------------------------------------------------------------
    // Defining document bihavior by class method
    //-----------------------------------------------------------------------------------------
    override class func autosavesDrafts() -> Bool {
        return false
    }
    
    override class func autosavesInPlace() -> Bool {
        return false
    }
    
    override class func preservesVersions() -> Bool {
        return false;
    }
    
    override class func usesUbiquitousStorage() -> Bool {
        return false;
    }
    
    //-----------------------------------------------------------------------------------------
    // Initializing document
    //-----------------------------------------------------------------------------------------
    init() {
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
    }

    override var windowNibName: String {
        return "Document"
    }


    //-----------------------------------------------------------------------------------------
    // Loading document
    //-----------------------------------------------------------------------------------------
    override func readFromURL(absoluteURL: NSURL?, ofType typeName: String?, error outError: NSErrorPointer) -> Bool {
        if let url = absoluteURL {
            var path = url.path
            root = FileNode(name: path.lastPathComponent,
                            folderName: path.stringByDeletingLastPathComponent,
                            isFolder: true)
        }
        return true;
    }

}

