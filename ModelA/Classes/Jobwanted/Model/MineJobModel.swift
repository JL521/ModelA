//
//  MineJobModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/15.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class MineJobModel: NSObject,Mappable {
    
    var id:Int?
    var jobName:String?
    var salary:String?
    var education:String?
    var workyears:String?
    var site:String?
    var companyName:String?
    var sjScore:Int?
    var applyId:Int?
    var noticeId:Int?
    var jobNumber:Int?
    
    var companyId:Int?
    var jobDescription:String?
    var orgLogo:String?
    var orgAddress:String?
    var orgProvince:String?
    var orgCity:String?
    var orgDistrict:String?
    var orgIntro:String?
    var delivered:Bool?
    
    /**
     企业
     */
    var positionId:Int?
    var releaseTime : String?
    var revisionTime:String?
    var inviteState:Int?
    var showState:Int?
    var manageState:Int?
    
    var province:String?
    var city:String?
    var qu:String?
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        id <- map["id"]
        jobName <- map["jobName"]
        salary <- map["salary"]
        education <- map["education"]
        workyears <- map["workyears"]
        site <- map["site"]
        companyName <- map["companyName"]
        sjScore <- map["sjScore"]
        applyId <- map["applyId"]
        noticeId <- map["noticeId"]
        jobNumber <- map["jobNumber"]
        
        companyId <- map["companyId"]
        jobDescription <- map["jobDescription"]
        orgLogo <- map["orgLogo"]
        orgAddress <- map["orgAddress"]
        orgProvince <- map["orgProvince"]
        orgCity <- map["orgCity"]
        orgDistrict <- map["orgDistrict"]
        orgIntro <- map["orgIntro"]
        delivered <- map["delivered"]
        
        positionId <- map["positionId"]
        releaseTime <- map["releaseTime"]
        revisionTime <- map["revisionTime"]
        inviteState <- map["inviteState"]
        showState <- map["showState"]
        manageState <- map["manageState"]
        
        province <- map["province"]
        city <- map["city"]
        qu <- map["city"]
        
    }
    
}
