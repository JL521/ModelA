//
//  IndustriesModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/13.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class IndustriesModel: NSObject,Mappable {
    
    var id:Int?
    var industryName:String?
    var positionName:String?
  
    required init?(map: Map) {}
    
     func mapping(map: Map) {
        id <- map["id"]
        industryName <- map["industryName"]
        positionName <- map["positionName"]
    }
}
