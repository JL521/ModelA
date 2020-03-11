//
//  JobWantReqAPI.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/13.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper

public enum JobWantReqAPI {

    case getRegion
    case getIndustries
    case getPositions([String:Any])
    case getYuexin([String:Any])
    case saveYXZW([String:Any])
    case getMyResume
    
    case updateResumeStatus([String:Any])
    
    case addWorkExperience([String:Any])
    case updateWorkExperience([String:Any])
    case deleteWorkExperience([String:Any])
    
    case addProjectExperience([String:Any])
    case updateProjectExperience([String:Any])
    case deleteProjectExperience([String:Any])
    
    case addEducationExperience([String:Any])
    case updateEducationExperience([String:Any])
    case deleteEducationExperience([String:Any])
    
    case getApplyPostList([String:Any])
    case getPostDetail([String:Any])
    
    case getInvitePostList([String:Any])
    case getInterviewInvitation([String:Any])
    case acceptInvitation([String:Any])
    case deleteInvitation([String:Any])
    case getCompanyInfo([String:Any])
    case getCompanyPostList([String:Any])
    
    case applyPost([String:Any])
    case getPostList([String:Any])
    case checkResumeExist
    
    
    /*
     企业端
     */
    case getVuate([String:Any])
    case getCurriculumVitae([String:Any])
    case addinit([String:Any])
    case allinit([String:Any])
    case getVuatebyState([String:Any])
    case getmanagejob([String:Any])
    case addmanagejob([String:Any])
    case getbyId([String:Any])
    case updateJob([String:Any])
    case deleteJob([String:Any])
    case getVitaeByJobName([String:Any])
    case getCurriculumUser([String:Any])
    
    
}

let JobRequestAPIProvider = MoyaProvider<JobWantReqAPI>(plugins:[ReLoginPlugin()])

extension JobWantReqAPI:TargetType{
    
    public var baseURL: URL {
        return URL.init(string: baseUrl())!
    }
    
    public var path: String {
        switch self {
        
        case .getRegion:
            return "api/getRegion/getRegion"
        case .getIndustries:
            return "api/getIndustries"
        case .getMyResume:
            return "api/myResume/getMyResume"
        case .getPositions(_):
            return "api/getPositions"
        case .getYuexin(_):
            return "api/getOptions"
        case .saveYXZW(_):
            return "api/myResume/editMyResume"
            
        case .updateResumeStatus(_):
            return "api/myResume/updateResumeStatus"
            
        case .addWorkExperience(_):
            return "api/myResume/addWorkExperience"
        case .updateWorkExperience(_):
            return "api/myResume/updateWorkExperience"
        case .deleteWorkExperience(_):
            return "api/myResume/deleteWorkExperience"
            
        case .addProjectExperience(_):
            return "api/myResume/addProjectExperience"
        case .updateProjectExperience(_):
            return "api/myResume/updateProjectExperience"
        case .deleteProjectExperience(_):
            return "api/myResume/deleteProjectExperience"
            
        case .addEducationExperience(_):
            return "api/myResume/addEducationExperience"
        case .updateEducationExperience(_):
            return "api/myResume/updateEducationExperience"
        case .deleteEducationExperience(_):
            return "api/myResume/deleteEducationExperience"
        
            
        case .getApplyPostList(_):
            return "api/jobSearch/getApplyPostList"
        case .getPostDetail(_):
            return "api/jobSearch/getPostDetail"
            
        case .getInvitePostList(_):
            return "api/jobSearch/getInvitePostList"
        case .getInterviewInvitation(_):
            return "api/jobSearch/getInterviewInvitation"
        case .acceptInvitation(_):
            return "api/jobSearch/acceptInvitation"
        case .deleteInvitation(_):
            return "api/jobSearch/deleteInvitation"
        case .getCompanyInfo(_):
            return "api/jobSearch/getCompanyInfo"
        case .getCompanyPostList(_):
            return "api/jobSearch/getCompanyPostList"
            
        case .applyPost(_):
            return "api/jobSearch/applyPost"
        case .getPostList(_):
            return "api/jobSearch/getPostList"
        case .checkResumeExist:
            return "api/myResume/checkResumeExist"
            
        /**
            企业
        */
        case .getVuate(_):
            return "api/job/getVuate"
        case .getCurriculumVitae(_):
            return "api/wantjob/getCurriculumVitae"
        case .addinit(_):
            return "api/job/addinit"
        case .allinit(_):
            return "api/job/allinit"
        case .getVuatebyState(_):
            return "api/job/getVuatebyState"
        case .getmanagejob(_):
            return "api/job/get"
        case .addmanagejob(_):
            return "api/job/add"
        case .getbyId(_):
            return "api/job/getbyId"
        case .updateJob(_):
            return "api/job/updateId"
        case .deleteJob(_):
            return "api/job/delete"
        case .getVitaeByJobName(_):
            return "api/wantjob/getVitaeByJobName"
        case .getCurriculumUser(_):
            return "api/wantjob/getCurriculumUser"

        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getRegion:
              return .get
        default:
            return .post
        }
    }
    

    public var parameters: [String: Any]? {
        switch self {
        case .getPositions(let parm):
            return parm
        case .saveYXZW(let parm):
            return parm
        case .getYuexin(let parm):
            return parm
            
        case .addWorkExperience(let parm),.updateWorkExperience(let parm),.deleteWorkExperience(let parm):
            return parm
            
        case .addProjectExperience(let parm),.updateProjectExperience(let parm),.deleteProjectExperience(let parm):
            return parm
            
        case .addEducationExperience(let parm),.updateEducationExperience(let parm),.deleteEducationExperience(let parm):
            return parm
            
        case .updateResumeStatus(let parm):
            return parm
            
        case .getApplyPostList(let parm):
            return parm
        case .getPostDetail(let parm):
            return parm
            
        case .getInvitePostList(let parm) , .getInterviewInvitation(let parm),.acceptInvitation(let parm),.deleteInvitation(let parm),.getCompanyInfo(let parm),.getCompanyPostList(let parm):
            return parm
            
        case .applyPost(let parm),.getPostList(let parm):
            return parm
        
        case .getRegion,.getIndustries,.getMyResume,.checkResumeExist:
            return nil
            
            
        case .getVuate(let parm),.getCurriculumVitae(let parm),.addinit(let parm),.allinit(let parm),.getVuatebyState(let parm),.getmanagejob(let parm),.addmanagejob(let parm),.getbyId(let parm),.updateJob(let parm),.deleteJob(let parm),.getVitaeByJobName(let parm),.getCurriculumUser(let parm):
            return parm
            
        }
    }
    
    public var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        
        case .getPositions(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
        case .getYuexin(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
        case .saveYXZW(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .addWorkExperience(let parms),.updateWorkExperience(let parms),.deleteWorkExperience(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .addProjectExperience(let parms),.updateProjectExperience(let parms),.deleteProjectExperience(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .addEducationExperience(let parms),.updateEducationExperience(let parms),.deleteEducationExperience(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
        case .updateResumeStatus(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .getPostDetail(let parms),.getApplyPostList(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .getInvitePostList(let parms),.getInterviewInvitation(let parms),.acceptInvitation(let parms),.deleteInvitation(let parms),.getCompanyInfo(let parms),.getCompanyPostList(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .applyPost(let parms),.getPostList(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        case .getMyResume,.getRegion,.getIndustries,.checkResumeExist:
                return Task.requestPlain
            
            
        case .getVuate(let parms),.getCurriculumVitae(let parms),.addinit(let parms),.allinit(let parms),.getVuatebyState(let parms),.getmanagejob(let parms),.addmanagejob(let parms),.getbyId(let parms),.updateJob(let parms),.deleteJob(let parms),.getVitaeByJobName(let parms),.getCurriculumUser(let parms):
            return Task.requestParameters(parameters:parms, encoding: URLEncoding.default)
            
        }
    }
    
    public var headers: [String : String]? {
        guard let language = currentLanguages as? [String],let token = GlobalModel.shared.token else {
            return ["Accept-Language":"zh"]
        }
        if language[0].hasPrefix("en"){
            return ["Accept-Language":"en"]
        }
        return ["Accept-Language":"zh","token":token]
    }
    
}
