//
//  MineJobExpectTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/9.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class MineJobExpectTableViewCell: UITableViewCell {

    @IBOutlet weak var namel: UILabel!
    @IBOutlet weak var moneyl: UILabel!
    @IBOutlet weak var adddressl: UILabel!
    @IBOutlet weak var hangyel: UILabel!
    @IBOutlet weak var stael: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func setDataWithModel(mode:MineResumeModel?)  {
        
        if let model = mode {
            namel.text = model.positionName
            moneyl.text = model.salary
            adddressl.text = (model.province ?? "") + "" + (model.city ?? "")
            hangyel.text = model.industryName
            stael.text = model.jobStatus
            
        }
        
    }
    
}
