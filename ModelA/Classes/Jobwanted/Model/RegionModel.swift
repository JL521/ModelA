//
//  RegionModel.swift
//  Rencaiyoujia
//
//  Created by 姜磊 on 2020/2/11.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class RegionModel: NSObject ,Mappable {
    
    var title : String?
    var ad_code : String?
    var child : [RegionModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        title <- map["title"]
        ad_code <- map["ad_code"]
        child <- map["child"]
        
    }
    
    
    

}
