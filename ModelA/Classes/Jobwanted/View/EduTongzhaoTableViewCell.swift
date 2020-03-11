//
//  EduTongzhaoTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/14.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class EduTongzhaoTableViewCell: UITableViewCell {

    @IBOutlet weak var namel: UILabel!
    @IBOutlet weak var yesbtn: UIButton!
    @IBOutlet weak var nobtn: UIButton!
    
    var tzblock:((_ str:String?)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(str:String?) {
        clear()
        if str=="0" {
            nobtn.setImage(UIImage(named: "empowe_check"), for: .normal)
        }else{
            yesbtn.setImage(UIImage(named: "empowe_check"), for: .normal)
        }
    }
    
    func clear() {
        yesbtn.setImage(UIImage(named: "empowe_uncheck"), for: .normal)
        nobtn.setImage(UIImage(named: "empowe_uncheck"), for: .normal)
    }
    
    @IBAction func istz(_ sender: UIButton) {
        clear()
        if sender.tag==0 {
            nobtn.setImage(UIImage(named: "empowe_check"), for: .normal)
        }else{
            yesbtn.setImage(UIImage(named: "empowe_check"), for: .normal)
        }
        if let block = tzblock {
            block("\(sender.tag)")
        }
    }
}
