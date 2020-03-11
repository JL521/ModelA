//
//  BusiResumeDetaiModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class BusiResumeDetaiModel: NSObject,Mappable {
    
    var jobName:String?
    var companyName:String?
    var accept_state:Int?
    var resume : MineResumeModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        jobName <- map["jobName"]
        companyName <- map["companyName"]
        accept_state <- map["accept_state"]
        resume <- map["resume"]
    }
    

}
