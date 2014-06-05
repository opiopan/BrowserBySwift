//
//  Model.swift
//  BrowserBySwift
//
//  Created by opiopan on 2014/06/06.
//  Copyright (c) 2014年 opiopan. All rights reserved.
//

import Cocoa

class FileNode : NSObject, NSCopying {
    //-----------------------------------------------------------------------------------------
    // Properties
    //-----------------------------------------------------------------------------------------
    var me: FileNode {return self}
    var name: String
    var folderName: String
    var isFolder: Bool
    var icon: NSImage? {
        return NSWorkspace.sharedWorkspace().iconForFile(self.folderName + "/" + self.name)
    }
    @lazy var childFolders: FileNode[] = self.buildChildren(true)
    @lazy var childFiles: FileNode[] = self.buildChildren(false)
    var children: FileNode[]{
        return childFolders
    }
    var allChildren: FileNode[]{
        return self.childFolders + self.childFiles
    }
    var isLeaf: Bool{
        if isFolder {
            return self.childFolders.isEmpty && self.childFiles.isEmpty
        }else{
            return true
        }
    }
    
    //-----------------------------------------------------------------------------------------
    // Initializer
    //-----------------------------------------------------------------------------------------
    init(name: String, folderName: String, isFolder: Bool){
        self.name = name
        self.folderName = folderName
        self.isFolder = isFolder
    }
    
    func buildChildren(buildFolders: Bool) -> FileNode[] {
        var rc: FileNode[] = []
        if self.isFolder {
            let base = self.folderName + "/" + self.name
            let fileManager = NSFileManager.defaultManager()
            if let fnames = fileManager.contentsOfDirectoryAtPath(base, error: nil) as? String[]{
                for fname in fnames{
                    var isDir: ObjCBool = false
                    if fileManager.fileExistsAtPath(base + "/" + fname, isDirectory: &isDir){
                        if (!buildFolders || isDir == true) && fname.substringToIndex(1) != "." {
                            rc += FileNode(name: fname, folderName: base, isFolder: isDir)
                        }
                    }
                }
            }
        }
        return rc
    }
    
    //-----------------------------------------------------------------------------------------
    // Imprementation for NSCopying protcol
    //-----------------------------------------------------------------------------------------
    func copyWithZone(_zone: NSZone) -> AnyObject!{
        return self
    }
}
