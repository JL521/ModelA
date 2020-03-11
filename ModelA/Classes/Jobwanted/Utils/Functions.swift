//
//  Functions.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/12.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Foundation
import UIKit

let APP_NAME = Bundle.main.infoDictionary!["CFBundleName"] as! String
let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let APP_BUILD_VERSION = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

func RCLOG<T>(message:T,file:String = #file,funcName:String = #function,lineName:Int = #line){
    #if DEBUG
    let  flieName = (file as NSString).lastPathComponent
    print("\(APP_NAME)/\(flieName)/\(funcName)/\(lineName):\(message)")
    #endif
}

//MARK: - 工具方法

///获取当前控制器
func currentVc() ->UIViewController{
    var vc = UIApplication.shared.keyWindow?.rootViewController
    if (vc?.isKind(of: UITabBarController.self))! {
        vc = (vc as! UITabBarController).selectedViewController
    }else if (vc?.isKind(of: UINavigationController.self))!{
        vc = (vc as! UINavigationController).visibleViewController
    }else if ((vc?.presentedViewController) != nil){
        vc =  vc?.presentedViewController
    }
    return vc!
}


/// 比较数组是否大于制定数量,用于分页请求
///
/// - Parameters:
///   - array: 数组
///   - number: 指定数
/// - Returns: 是否大于
func compareArrayCountIsLessThanNumber<T>(array:[T],number:Int) -> Bool {
    return array.count < number
}

///获得storyBoard 里的控制器
func getStoryBoardViewController(storyName:StoryBoardName,controllerIdentity:StroyBoardViewcontrollerIdentity) -> UIViewController{
    
    
    let bundle = Bundle(for: JobWantListControllerViewController.classForCoder())
    let sb = UIStoryboard.init(name: storyName.rawValue, bundle: bundle)
    let vc = sb.instantiateViewController(withIdentifier: controllerIdentity.rawValue)
    return vc
}

//设置为全局封装，以后可以统一更改样式
func showToast(position:ToastPosition = .bottom,info:String) {
    getTopVC()?.view.endEditing(true)
    Toast.shared.showToast(position:position, info: info)
}


// MARK: - 查找顶层控制器、
 // 获取顶层控制器 根据window
func getTopVC() -> (UIViewController?) {
    var window = UIApplication.shared.keyWindow
    //是否为当前显示的window
    if window?.windowLevel != UIWindow.Level.normal{
      let windows = UIApplication.shared.windows
      for  windowTemp in windows{
        if windowTemp.windowLevel == UIWindow.Level.normal{
          window = windowTemp
          break
      }
    }
  }
  let vc = window?.rootViewController
  return getTopVC(withCurrentVC: vc)
}

///根据控制器获取 顶层控制器
func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
     if VC == nil {
        print("🌶： 找不到顶层控制器")
        return nil
    }
     if let presentVC = VC?.presentedViewController {
        //modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    }else if let tabVC = VC as? UITabBarController {
      // tabBar 的跟控制器
        if let selectVC = tabVC.selectedViewController {
          return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
      // 控制器是 nav
        return getTopVC(withCurrentVC:naiVC.visibleViewController)
      } else {
      // 返回顶控制器
      return VC
      }
}

//退出登录
func loginOut(){
    GlobalModel.shared.token = ""
    GlobalModel.shared.isLogin = "0"
    GlobalModel.shared.oldLoginType =  GlobalModel.shared.loginType
    GlobalModel.shared.synchronize()
    NotificationCenter.default.post(name: NSNotification.Name.init(NotificationKey.UpdateMineUI.rawValue), object: nil)
}


func call(phoneNumber:String){
    // phoneStr:  电话号码
    let phone = "telprompt://" + phoneNumber
    if UIApplication.shared.canOpenURL(URL(string: phone)!) {
        UIApplication.shared.openURL(URL(string: phone)!)
    }
}

//画虚线
func drawDashImage(imageView:UIImageView) -> UIImage {
    
    UIGraphicsBeginImageContext(imageView.frame.size)
    
    let context = UIGraphicsGetCurrentContext()
    context?.setLineCap(CGLineCap.square)
    
    let lengths:[CGFloat] = [2,4,]
    
    context?.setStrokeColor(UIColor.lightGray.cgColor)
    context?.setLineWidth(2)
    context?.setLineDash(phase: 0, lengths: lengths)
    context?.move(to: CGPoint(x: 10, y: 0))
    context?.addLine(to: CGPoint(x: imageView.bounds.width, y: 0))
    context?.strokePath()
    
    return UIGraphicsGetImageFromCurrentImageContext()!
}


/// 设置渐变色
func gradientLayer(superView:UIView,beginColor:UIColor,endColor:UIColor) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    gradientLayer.frame = superView.bounds
    gradientLayer.colors = [beginColor.cgColor,endColor.cgColor]
    gradientLayer.cornerRadius = 5
    superView.layer.addSublayer(gradientLayer)
}

//MARK: - Xib视图
enum XibName:String {
    case FourCaiTextView = "FourCaiTextView"
    case FourCaiSelectView = "FourCaiSelectView"
    case FourCaiSelectCustomView = "FourCaiSelectCustomView"
    case FourCaiImageView = "FourCaiImageView"
    case FourCaiDetailView = "FourCaiDetailView"
    case AddressPickerRow = "AddressPickerRow"
    case NoRecruitView = "NoRecruitView"
    case ValidateCodeAlertView = "ValidateCodeAlertView"
    case UploadImageRow = "UploadImageRow"
    case BankCardView = "BankCardView"
}

//加载xib view
func loadXibView<T:UIView>(name:XibName,owner:Any? ) -> T?{
    if let view = Bundle.main.loadNibNamed(name.rawValue, owner: owner, options:nil)?.last as? T{
        return view;
    }
    return nil
}
