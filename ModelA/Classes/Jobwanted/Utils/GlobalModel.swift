//
//  GlobalModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/24.
//  Copyright © 2019 zhangyu. All rights reserved.
//  全局单例模型，如果自动登录需要缓存到硬盘

import UIKit
import ObjectMapper

class GlobalModel: NSObject,Mappable{
   
    static let shared = GlobalModel()
    
    @objc var isLogin:String? = "0"
    @objc var token:String?
    @objc var loginAccount:String?
    @objc var password:String?
    @objc var loginType:String? = "1"
    @objc var oldLoginType:String? = nil
    @objc var shopId:String?
    @objc var hasShop:String? = "0"
    
    var isCheck:Bool = false

    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map) {
        isLogin <- map["isLogin"]
        token <- map["token"]
        loginAccount <- map["loginAccount"]
        password <- map["password"]
        loginType <- map["loginType"]
    }
    
    func synchronize(){
        UserDefaults.standard.set(GlobalModel.shared.toJSON(), forKey: UserDefaultKeys.GlobalModelKey.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func autoLoginGlobalFromDisk() {
        if let modelData = UserDefaults.standard.object(forKey: UserDefaultKeys.GlobalModelKey.rawValue) as? [String:Any]{
            GlobalModel.shared.setValuesForKeys(modelData)
        }
        loaUserInfo()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

func loaUserInfo(){
    if GlobalModel.shared.isLogin == "1"{
        
    }
}

