//
//  JobDetaiTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/10.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class JobDetaiTableViewCell: UITableViewCell {

    @IBOutlet weak var titll: UILabel!
    @IBOutlet weak var desl: UILabel!
    @IBOutlet weak var companyBtn: UIButton!
    
    var lookCompanyBlock:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    @IBAction func lookCompany(_ sender: UIButton) {
        if let block = lookCompanyBlock {
            block()
        }
    }
    
}
