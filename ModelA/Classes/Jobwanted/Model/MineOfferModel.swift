//
//  MineOfferModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/15.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class MineOfferModel: NSObject,Mappable {
    var id:Int?
    var companyId:Int?
    var companyName:String?
    var jobName:String?
    var workyears:String?
    var interviewTime:String?
    var sjScore:Int?
    var applyId:Int?
    var acceptState:Int?
    var contate:String?
    var phone:String?
    var attention:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       
        id <- map["id"]
        companyId <- map["companyId"]
        companyName <- map["companyName"]
        jobName <- map["jobName"]
        workyears <- map["workyears"]
        interviewTime <- map["interviewTime"]
        sjScore <- map["sjScore"]
        applyId <- map["applyId"]
        acceptState <- map["acceptState"]
        contate <- map["contate"]
        phone <- map["phone"]
        attention <- map["attention"]
        
    }
    

}
