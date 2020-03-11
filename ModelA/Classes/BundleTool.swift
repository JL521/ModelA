//
//  BundleTool.swift
//  ModelA_Example
//
//  Created by 姜磊 on 2020/3/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class BundleTool: NSObject {
    

  public  class func getBundle() -> Bundle{
    
        return Bundle(for:self.classForCoder())
    
    }
    
    
   public class func getImage(str:String,type:String="png") -> UIImage {
        return UIImage.init(contentsOfFile: getBundle().path(forResource: str, ofType: type) ?? "") ?? UIImage()
    }
    
}
