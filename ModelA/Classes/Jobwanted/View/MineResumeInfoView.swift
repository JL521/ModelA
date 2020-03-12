//
//  MineResumeInfoView.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/9.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import SDWebImage

class MineResumeInfoView: UIView {

    @IBOutlet weak var usernamel: UILabel!
    @IBOutlet weak var sjl: UILabel!
    @IBOutlet weak var headimgv: UIImageView!
    @IBOutlet weak var sexl: UILabel!
    @IBOutlet weak var agel: UILabel!
    @IBOutlet weak var workexprel: UILabel!
    
    func setDataWithModel(mode:MineResumeModel?) {
        
        if let model = mode {
            usernamel.text = model.userName
            sjl.text = "评估身价："+(model.sjScore ?? "")+"万"
            
            let url = URL.init(string: model.headPhotoPath?.https() ?? "")
            headimgv?.sd_setImage(with: url, placeholderImage: BundleTool.getImage(str: "wd_tx"), options: .retryFailed, completed: nil)
            
            sexl.text = model.gender
            agel.text = (model.age ?? "0")+"岁"
            workexprel.text = (model.workYears ?? "0")+"年工作经验"
        }
        
    }
    
}
