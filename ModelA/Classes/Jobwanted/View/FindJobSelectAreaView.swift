//
//  FindJobSelectAreaView.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/17.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class FindJobSelectAreaView: UIView {

    @IBOutlet weak var provicel: UILabel!
    
    @IBOutlet weak var cityl: UILabel!
    
//    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var proBtn: UIButton!
    var regionBlock: ((_ type : Int)->())?
    
    @IBAction func selectArea(_ sender: UIButton) {
        print("选择地区")
        if let block = self.regionBlock {
            block(sender.tag)
        }
        
    }
   
}
