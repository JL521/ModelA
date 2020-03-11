//
//  APIServer.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/6.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Moya

func baseUrl() -> String{
    #if DEBUG
         return (GlobalModel.shared.loginType == "1" ? "http://39.105.40.214:8080/rcyjplatformc/" : "http://39.105.40.214:8080/enterprise")
    #else
         return (GlobalModel.shared.loginType == "1" ? "https://www.rencaiyoujia.com/rcyjplatformc/" : "https://www.rencaiyoujia.com/enterprise/")
    #endif
}

#if DEBUG
let singleBaseUrl = "http://39.105.40.214:8080/rcyjplatformc/"
#else
let singleBaseUrl = "https://www.rencaiyoujia.com/rcyjplatformc/"
#endif

#if DEBUG
let singleEnterpriseBaseUrl = "http://39.105.40.214:8080/enterprise"
#else
let singleEnterpriseBaseUrl = "https://www.rencaiyoujia.com/enterprise/"
#endif

#if DEBUG
let webBaseUrl = "http://rcyj4.0.zdcom.net.cn"
#else
let webBaseUrl = "https://www.m.rencaiyoujia.com"
#endif


func govermentUrl() -> String{
    #if DEBUG
         return (GlobalModel.shared.loginType == "1" ? "http://govjob.zdcom.net.cn" : "http://govjob.zdcom.net.cn")
    #else
         return (GlobalModel.shared.loginType == "1" ? "https://www.m.govjob.rencaiyoujia.com" : "https://www.m.govjob.rencaiyoujia.com")
    #endif
}

public var atricleUrl: String{
    #if DEBUG
         return "http://rcyj4.0.zdcom.net.cn/NewsDetail?articleId=%d"
    #else
         return "https://www.m.rencaiyoujia.com/NewsDetail?articleId=%d"
    #endif
}

public var gardenApplyUrl: String = webBaseUrl + "/Entrance?token=%@&isLoggedIn=1&device=ios&realName=%@"
public var gorvmentUrl: String = govermentUrl() + "/JobBidding?token=%@&device=iOS"
public var expertUrl: String = webBaseUrl + "/ServiceRequest?token=%@&device=ios&isLoggedIn=0&realName=%@"
public var visitEnterpriseUrl: String = webBaseUrl + "/bianfangminqi/index.html?device=1"
public var RecruitmentManagementUrl: String = webBaseUrl + "/Recruiting?token=%@&isLoggedIn=1&device=IOS&realName=%@"
public var ResumeListUrl: String = webBaseUrl + "/ResumeList?token=%@&isLoggedIn=1&device=IOS&realName=%@"
public var EnableJobListUrl: String = webBaseUrl + "/EnableJobList?token=%@&isLoggedIn=1&device=IOS&realName=%@"
public var JobInfoUrl: String = webBaseUrl + "/JobInfo?token=%@&isLoggedIn=1&device=IOS&realName=%@"
public var homeSearchUrl: String = webBaseUrl + "/Search?type=app&userType=%@"
public var JobReleaseUrl: String = webBaseUrl + "/JobRelease?token=%@&isLoggedIn=1&device=IOS&realName=%@"

func userType() -> String{
    if GlobalModel.shared.isLogin == "1"{
        return GlobalModel.shared.loginType ?? "3"
    }else{
        return ""
    }
}

///网络插件
public let networkActivityPlugin = NetworkActivityPlugin { (type, _) in
    switch(type) {
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

