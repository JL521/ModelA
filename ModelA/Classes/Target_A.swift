//
//  Target_A.swift
//  A_swift
//
//  Created by casa on 2017/1/4.
//  Copyright © 2017年 casa. All rights reserved.
//

import UIKit

@objc class Target_A: NSObject {

    @objc func Action_Extension_ViewController(_ params:NSDictionary) -> UIViewController {
        if let callback = params["callback"] as? (String) -> Void {
            callback("success")
        }

        let aViewController = ViewController()
        return aViewController
    }
    
    @objc func Action_UserJob_ViewController(_ params:NSDictionary) -> UIViewController {
        if let callback = params["callback"] as? (String) -> Void {
            callback("success")
        }
        
        if let token = params["token"] as? String
        {
            GlobalModel.shared.loginType = "1"
            GlobalModel.shared.isLogin = "1"
            GlobalModel.shared.token = token
        }

        print(params)
        let stob = UIStoryboard.init(name: "Jobwanted", bundle: BundleTool.getBundle())
        let vc = stob.instantiateViewController(withIdentifier: "JobWantListControllerViewController")
        return vc
    }
    
    @objc func Action_UserFindJob_ViewController(_ params:NSDictionary) -> UIViewController {
        if let callback = params["callback"] as? (String) -> Void {
            callback("success")
        }

        if let token = params["token"] as? String
        {
            GlobalModel.shared.loginType = "1"
            GlobalModel.shared.isLogin = "1"
            GlobalModel.shared.token = token
        }
        
        let vc = FindJobViewController()
        return vc
    }
    
    @objc func Action_QYJob_ViewController(_ params:NSDictionary) -> UIViewController {
        if let callback = params["callback"] as? (String) -> Void {
            callback("success")
        }

        if let token = params["token"] as? String
        {
            GlobalModel.shared.loginType = "1"
            GlobalModel.shared.isLogin = "1"
            GlobalModel.shared.token = token
        }
        
        let stob = UIStoryboard.init(name: "ManagerPosition", bundle: BundleTool.getBundle())
        let vc = stob.instantiateViewController(withIdentifier: "ManagerPositionTableViewController")
        return vc
    }
    
    @objc func Action_QYFindPeople_ViewController(_ params:NSDictionary) -> UIViewController {
        if let callback = params["callback"] as? (String) -> Void {
            callback("success")
        }
        
        if let token = params["token"] as? String
        {
            GlobalModel.shared.loginType = "1"
            GlobalModel.shared.isLogin = "1"
            GlobalModel.shared.token = token
        }

        let vc = BusiFindPeopleViewController()
        return vc
    }
    
    @objc func Action_Category_ViewController(_ params:NSDictionary) -> UIViewController {
        
        if let block = params["callback"] {
            
            typealias CallbackType = @convention(block) (NSString) -> Void
            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
            let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
            
            callback("success")
        }
        
        let aViewController = ViewController()
        return aViewController
    }
}
