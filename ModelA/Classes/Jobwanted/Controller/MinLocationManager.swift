//
//  MinLocationManager.swift
//  Rencaiyoujia
//
//  Created by 姜磊 on 2020/2/25.
//  Copyright © 2020 zhangyu. All rights reserved.
//


import CoreLocation
import UIKit

typealias MKPositioningClosure = (String) -> ()
typealias MKProviceClosure = (String) -> ()


class MinLocationManager: NSObject {
    
       public static let shared = MinLocationManager()
        
        var clousre : MKPositioningClosure?
        var provice : MKProviceClosure?
        private var locationManager : CLLocationManager?
        private var viewController : UIViewController?      // 承接外部传过来的视图控制器，做弹框处理
        
        
        // 外部初始化的对象调用，执行定位处理。
        func startPositioning(_ vc:UIViewController) {
            viewController = vc
            if (self.locationManager != nil) && (CLLocationManager.authorizationStatus() == .denied) {
                // 定位提示
                alter(viewController: viewController!)
            } else {
                requestLocationServicesAuthorization()
            }
        }
        
        
        // 初始化定位
        private func requestLocationServicesAuthorization() {
            
            if (self.locationManager == nil) {
                self.locationManager = CLLocationManager()
                self.locationManager?.delegate = self
            }
            
            self.locationManager?.requestWhenInUseAuthorization()
            self.locationManager?.requestAlwaysAuthorization()
            
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            let distance : CLLocationDistance = 10.0
            locationManager?.distanceFilter = distance
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
            
            self.locationManager?.startUpdatingLocation()
            

        }
        
        
        // 获取定位代理返回状态进行处理
        private func reportLocationServicesAuthorizationStatus(status:CLAuthorizationStatus) {
            
            if status == .notDetermined {
                // 未决定,继续请求授权
                requestLocationServicesAuthorization()
            } else if (status == .restricted) {
                // 受限制，尝试提示然后进入设置页面进行处理
                alter(viewController: viewController!)
            } else if (status == .denied) {
                // 受限制，尝试提示然后进入设置页面进行处理
                alter(viewController: viewController!)
            }
        }
        
        
        private func alter(viewController:UIViewController) {
            
//            AlertController.shared.showAlertMsg(viewController, "定位服务未开启,是否前往开启?", "请进入系统[设置]->[隐私]->[定位服务]中打开开关，并允许“赏金猎人”使用定位服务") { (action) in
//                let url = URL(fileURLWithPath: UIApplicationOpenSettingsURLString)
//                if UIApplication.shared.canOpenURL(url){
//                    UIApplication.shared.openURL(url)
//                }
//            }
            
            showToast(info: "定位服务未开启")
            
            print("地址位置受限制")
        }

}

extension MinLocationManager:  CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager?.stopUpdatingLocation()
        
        print("迪欧之威力")
        
        let location = locations.last ?? CLLocation()
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                if self.clousre != nil {
                    self.clousre!(error?.localizedDescription ?? "")
                }
                return
            }
            
            if let place = placemarks?[0]{
                
                // 国家 省  市  区  街道  名称  国家编码  邮编
//                let country = place.country ?? ""
                let administrativeArea = place.administrativeArea ?? ""
                let locality = place.locality ?? ""
                let subLocality = place.subLocality ?? ""
                let thoroughfare = place.thoroughfare ?? ""
                let name = place.name ?? ""
                let addressLines =  administrativeArea + locality + subLocality + thoroughfare + name
                if (self.clousre != nil) {
                    self.clousre!(addressLines)
                }
                
                if (self.provice != nil) {
                    self.provice!(administrativeArea)
                }
                
               
            } else {
                
                if self.clousre != nil {
                    self.clousre!("No placemarks!")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        reportLocationServicesAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager?.stopUpdatingLocation()
    }
}

