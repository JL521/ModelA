//
//  ICouldManager.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/11/4.
//  Copyright © 2019 zhangyu. All rights reserved.
//

class ICouldManager {
    public static func iCouldEnable() -> Bool {
        let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)
        return (url != nil)
    }
    
    public static func downloadFile(WithDocumentUrl url: URL, completion: ((Data) -> Void)? = nil) {
        let document = ZYDocument.init(fileURL: url)
        document.open { (success) in
            if success {
                document.close(completionHandler: nil)
            }
            if let callback = completion {
                callback(document.data)
            }
        }
    }
}

class ZYDocument: UIDocument {
    public var data = Data.init()
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        self.data = contents as! Data
    }
}
