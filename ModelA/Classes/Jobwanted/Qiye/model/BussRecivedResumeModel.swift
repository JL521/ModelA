//
//  BussRecivedResumeModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class BussRecivedResumeModel: NSObject,Mappable {
    
    var id : Int?
    var userId : Int?
    var companyId : Int?
    var vataeId : Int?
    var vataeDatailsId : Int?
    var jobId : Int?
    var isvisibleApplicant : Int?
    var isvisibleRecruits : Int?
    var acceptState : Int?
    var jobUserId : Int?
    var money : Int?
    var createtime : String?
    var userName : String?
    var picture : String?
    var workTime : String?
    var workingSpace : String?
    var education : String?
    var moneys : String?
    var jobName : String?
    
    //企业
    var positionName : String?
    var sjScore : String?
    var workYears : String?
    
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        companyId <- map["companyId"]
        vataeId <- map["vataeId"]
        vataeDatailsId <- map["vataeDatailsId"]
        jobId <- map["jobId"]
        isvisibleApplicant <- map["isvisibleApplicant"]
        isvisibleRecruits <- map["isvisibleRecruits"]
        acceptState <- map["acceptState"]
        jobUserId <- map["jobUserId"]
        money <- map["money"]
        createtime <- map["createtime"]
        userName <- map["userName"]
        picture <- map["picture"]
        workTime <- map["workTime"]
        workingSpace <- map["workingSpace"]
        education <- map["education"]
        moneys <- map["moneys"]
        jobName <- map["jobName"]
        
        positionName <- map["positionName"]
        sjScore <- map["sjScore"]
        workYears <- map["workYears"]
    }
    

}

class BussFindPeopleModel: NSObject,Mappable {
    
    var id : Int?
    var userId : Int?
    var companyId : Int?
    var vataeId : Int?
    var vataeDatailsId : Int?
    var jobId : Int?
    var positionId : Int?
    var isvisibleApplicant : Int?
    var isvisibleRecruits : Int?
    var acceptState : Int?
    var jobUserId : Int?
    var money : String?
    var createtime : String?
    var userName : String?
    var picture : String?
    var workTime : String?
    var workingSpace : String?
    var education : String?
    var moneys : String?
    var jobName : String?
    
    //企业
    var positionName : String?
    var sjScore : String?
    var workYears : String?
    
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        id <- map["id"]
        positionId <- map["positionId"]
        userId <- map["userId"]
        companyId <- map["companyId"]
        vataeId <- map["vataeId"]
        vataeDatailsId <- map["vataeDatailsId"]
        jobId <- map["jobId"]
        isvisibleApplicant <- map["isvisibleApplicant"]
        isvisibleRecruits <- map["isvisibleRecruits"]
        acceptState <- map["acceptState"]
        jobUserId <- map["jobUserId"]
        money <- map["money"]
        createtime <- map["createtime"]
        userName <- map["userName"]
        picture <- map["picture"]
        workTime <- map["workTime"]
        workingSpace <- map["workingSpace"]
        education <- map["education"]
        moneys <- map["moneys"]
        jobName <- map["jobName"]
        
        positionName <- map["positionName"]
        sjScore <- map["sjScore"]
        workYears <- map["workYears"]
    }
    

}
