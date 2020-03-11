//
//  MineCompanyModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/16.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class MineCompanyModel: NSObject,Mappable {
    
    var orgName : String?
    var logoUrl : String?
    var province : String?
    var city : String?
    var district : String?
    var intro : String?
    var sjScore : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       
        orgName <- map["orgName"]
        logoUrl <- map["logoUrl"]
        province <- map["province"]
        city <- map["city"]
        district <- map["district"]
        intro <- map["intro"]
        sjScore <- map["sjScore"]
        
    }
    

}
