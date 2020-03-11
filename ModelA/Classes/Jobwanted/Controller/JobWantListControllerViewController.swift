//
//  JobWantListControllerViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/8.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

public class JobWantListControllerViewController: UITableViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: BundleTool.getImage(str: "back"), style: .plain, target: self, action: #selector(realNameBack))
        
        let hv = UIView()
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 15)
        self.tableView.tableHeaderView = hv
        self.view.backgroundColor = UIColor(red: 243/255.0, green: 246/255.0, blue: 251/255.0, alpha: 1)
        
        setNavBarBackground(titlecolor: UIColor.init(hex: 0x494D58, alpha: 1), itemcolor: UIColor.init(hex: 0x494D58, alpha: 1), barcolor: UIColor.white)
        
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
        self.navigationController?.navigationBar.shadowImage = UIImage()
    
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
   
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
//            Router.jumpMineResumeController(nav: navigationController)
        }else if indexPath.section == 1 {
//            Router.jumpMineSendResumeController(nav: navigationController)
        }else if indexPath.section == 2 {
//            Router.jumpMineInvitationsReceivedController(nav: navigationController)
        }else if indexPath.section == 3 {
//            Router.jumpMineGetJobController(nav: navigationController)
        }
    }
    
}
