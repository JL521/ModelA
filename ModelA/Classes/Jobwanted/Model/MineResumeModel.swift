//
//  MineResumeModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/14.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import ObjectMapper

class MineResumeModel: NSObject ,Mappable{
    
    var userId:Int?
    var resumeStatus:Int?
    var province:String?
    var city:String?
    var industryId:Int?
    var positionId:Int?
    var salaryId:Int?
    var jobStatusId:Int?
    var gender:String?
    var workYears:String?
    var attachment:String?
    var userName:String?
    var sjScore:String?
    var headPhotoPath:String?
    var age:String?
    var industryName:String?
    var positionName:String?
    var salary:String?
    var jobStatus:String?
    
    var workExperienceList:[workExpreModel]?
    var projectExperienceList:[projectExpreModel]?
    var educationExperienceList:[MineEduModel]?
    
    required init?(map: Map) {
    }
    
     func mapping(map: Map) {
        userId <- map["userId"]
        resumeStatus <- map["resumeStatus"]
        province <- map["province"]
        city <- map["city"]
        industryId <- map["industryId"]
        positionId <- map["positionId"]
        salaryId <- map["salaryId"]
        jobStatusId <- map["jobStatusId"]
        gender <- map["gender"]
        workYears <- map["workYears"]
        attachment <- map["attachment"]
        userName <- map["userName"]
        sjScore <- map["sjScore"]
        headPhotoPath <- map["headPhotoPath"]
        age <- map["age"]
        industryName <- map["industryName"]
        positionName <- map["positionName"]
        salary <- map["salary"]
        jobStatus <- map["jobStatus"]
        workExperienceList <- map["workExperienceList"]
        projectExperienceList <- map["projectExperienceList"]
        educationExperienceList <- map["educationExperienceList"]
    }
    
}

class workExpreModel: NSObject,Mappable {
    
    var id:Int?
    var companyName:String?
    var positionName:String?
    var entryTime:String?
    var leaveTime:String?
    var jobDesc:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        companyName <- map["companyName"]
        positionName <- map["positionName"]
        entryTime <- map["entryTime"]
        leaveTime <- map["leaveTime"]
        jobDesc <- map["jobDesc"]
    }
    
    
}

class projectExpreModel: NSObject,Mappable {
    
    var id:Int?
    var projectName:String?
    var positionName:String?
    var startTime:String?
    var endTime:String?
    var projectDesc:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        projectName <- map["projectName"]
        positionName <- map["positionName"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        projectDesc <- map["projectDesc"]
    }
    
    
}

class MineEduModel: NSObject,Mappable {
    
    var id:Int?
    var educationId:Int?
    var degreeId:Int?
    var schoolName:String?
    var major:String?
    var studyTime:String?
    var graduateTime:String?
    var education:String?
    var degree:String?
    var unifiedEnroll:Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        schoolName <- map["schoolName"]
        major <- map["major"]
        studyTime <- map["studyTime"]
        graduateTime <- map["graduateTime"]
        education <- map["education"]
        degree <- map["degree"]
        educationId <- map["educationId"]
        degreeId <- map["degreeId"]
        unifiedEnroll <- map["unifiedEnroll"]
    }
    
    
}
