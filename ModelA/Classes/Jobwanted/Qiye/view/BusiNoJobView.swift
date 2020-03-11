//
//  BusiNoJobView.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class BusiNoJobView: UIView {

    var block : (()->())?
    
    @IBAction func publish(_ sender: UIButton) {
        if let b = block {
            b()
        }
    }
    @IBOutlet weak var publish: UIButton!
}
