//
//  RequestHudPlugin.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/16.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Moya
import Result
import UIKit

final class RequestHudPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        DispatchQueue.main.async {
           Activity.shared.show()
           RCLOG(message:request.request)
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        DispatchQueue.main.async {
            Activity.shared.dismiss()
        }
        switch result {
        case .success(let respons):
            RCLOG(message:try? respons.mapJSON())
        case .failure(let error):
            RCLOG(message: error.errorDescription)
        }
    }
    
    
    func networkError(){
        
    }
    
}
