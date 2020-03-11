//
//  InvitationsTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/10.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class InvitationsTableViewCell: UITableViewCell {

    @IBOutlet weak var companyl: UILabel!
    @IBOutlet weak var sjl: UILabel!
    
    @IBOutlet weak var sjview: UIView!
    @IBOutlet weak var statel: UILabel!
    @IBOutlet weak var timel: UILabel!
    @IBOutlet weak var zhiweil: UILabel!
    var deleteBlcok:(() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.addGestureRecognizer(longPressRecognizer)

    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UILongPressGestureRecognizer.State.began  {
            if let deb = deleteBlcok {
                deb()
            }
        }
    }
    
    func setDataWithModel(mode:MineOfferModel?) {
        if let model = mode{
            
            companyl.text = model.companyName
            sjl.text = "企业身价：\(model.sjScore ?? 0)万"
            zhiweil.text = "面试职位：\(model.jobName ?? "")"
            timel.text = model.interviewTime
            
        }
    }

}

