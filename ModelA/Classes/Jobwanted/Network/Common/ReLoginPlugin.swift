//
//  ReLoginPlugin.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/24.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Moya
import Result
import SwiftyJSON

final class ReLoginPlugin: PluginType {
    
    
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let value):
            guard let json = try? value.mapJSON() else{
                return
            }
            if JSON(json)["code"] == "102"{
               
            }
        case .failure(_):
            Activity.shared.dismiss()
        }
    }
    
}
