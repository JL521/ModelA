//
//  JobCompanyTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/10.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class JobCompanyTableViewCell: UITableViewCell {
    @IBOutlet weak var naml: UILabel!
    
    @IBOutlet weak var sjl: UILabel!
    @IBOutlet weak var imgv: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setJobDetailDataWithModel(mode:MineJobModel?) {
        if let model = mode {
            sjl.text = "企业身价：\(model.sjScore ?? 0)万"
            naml.text = model.companyName
            let url = URL.init(string: model.orgLogo?.https() ?? "")
            imgv?.sd_setImage(with: url, placeholderImage: UIImage(named: "wd_tx"), options: .retryFailed, completed: nil)
        }
    }
    
    func setCompanyDataWithModel(mode:MineCompanyModel?) {
        if let model = mode {
            sjl.text = "企业身价：\(model.sjScore ?? 0)万" 
            naml.text = model.orgName
            imgv.sd_setImage(with: URL.init(string: (model.logoUrl?.https() ?? "")), completed: nil)
        }
    }
    
}
