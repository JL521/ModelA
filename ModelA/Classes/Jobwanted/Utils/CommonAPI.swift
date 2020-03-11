//
//  CommonAPI.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/10/8.
//  Copyright © 2019 zhangyu. All rights reserved.
//


import Foundation
import Moya

let CommonAPIProvider = MoyaProvider<CommonAPI>(plugins:[ReLoginPlugin()])

public enum CommonAPI{
    case uploadFile(name:String,image:UIImage)
    case uploadDocumetFile(name:String,fileData:Data,type:String)
    case getServicePhone
    case getCity
    case getRegion
    case getOptions([String:Any])
    case getVersionInfo([String:Any])
}

extension CommonAPI:TargetType{
    
    public var baseURL: URL {
        return URL.init(string: baseUrl())!
    }
    
    public var path: String {
        switch self {
        case .uploadFile(_),.uploadDocumetFile(_):
            return "api/uploadOss/uploadFile"
        case .getServicePhone:
            return "api/getServicePhone"
        case .getCity:
            return "api/getRegion/getCity"
        case .getRegion:
            return "api/getRegion/getRegion"
        case .getOptions(_):
            return "api/getOptions"
        case .getVersionInfo(_):
            return "api/getVersionInfo"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .uploadFile(_),.uploadDocumetFile(_),.getOptions(_):
              return .post
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .uploadFile(let name,let image):
            let compressImage = image.compressImage(maxLength: 1024000)
            if let imageData = compressImage?.jpegData(compressionQuality: 1){
                let formData = MultipartFormData(provider: .data(imageData), name: "file", fileName: name + ".jpeg", mimeType: "image/jpeg")
                return .uploadMultipart([formData])
            }else{
                return Task.requestPlain
            }
        case .uploadDocumetFile(let name,let fileData,let type):
            
                let formData = MultipartFormData(provider: .data(fileData), name: "file", fileName: name, mimeType: type)
                return .uploadMultipart([formData])
        case .getOptions(let parms),.getVersionInfo(let parms):
            return Task.requestParameters(parameters: parms, encoding: URLEncoding.default)
        default :
            return Task.requestPlain
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
