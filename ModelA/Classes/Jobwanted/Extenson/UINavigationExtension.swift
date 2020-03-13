//
//  UINavigationExtension.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/10/18.
//  Copyright © 2019 zhangyu. All rights reserved.
//


import UIKit

extension  UIViewController{
    
    func leftIsCostomBack(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: BundleTool.getImage(str: "back"), style: .plain, target: self, action: #selector(back))
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func leftIsCostomBackDismiss(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: BundleTool.getImage(str: "back"), style: .plain, target: self, action: #selector(dismissBack))
    }
    
    @objc func dismissBack(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
     func baseColorNav(){
    self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.baseColor), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func defaultBgNav(){
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.darkText
    self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor : UIColor.darkText]
    }
    
    func navBaseColor(){
       self.navigationController?.navigationBar.barTintColor = UIColor.baseColor
       self.navigationController?.navigationBar.isTranslucent = false
       self.navigationController?.navigationBar.tintColor = UIColor.white
       self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func navDefaultColor(){
         self.navigationController?.navigationBar.barTintColor = nil
         self.navigationController?.navigationBar.isTranslucent = true
         self.navigationController?.navigationBar.tintColor = UIColor.darkText
         self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor : UIColor.darkText]
      }
}
