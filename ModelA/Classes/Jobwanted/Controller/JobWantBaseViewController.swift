//
//  JobWantBaseViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/8.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift


public class JobWantBaseViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false;
        self.view.backgroundColor = UIColor(red: 243/255.0, green: 246/255.0, blue: 251/255.0, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(realNameBack))
    }

    @objc func realNameBack() {
    self.navigationController?.popViewController(animated: true)
      }
    
    func setNavBarBackground(titlecolor:UIColor,itemcolor:UIColor,barcolor:UIColor) {
        self.navigationController?.navigationBar.barTintColor = barcolor
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: titlecolor,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        //item颜色
        self.navigationController?.navigationBar.tintColor = itemcolor
    }

}
