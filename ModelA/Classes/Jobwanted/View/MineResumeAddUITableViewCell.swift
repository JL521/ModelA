//
//  MineResumeAddUITableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/13.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class MineResumeAddUITableViewCell: UITableViewCell {

    @IBOutlet weak var titll: UILabel!
    @IBOutlet weak var textfiled: UITextField!
    var textChangeBlock:((_ str:String?)->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        let btn = UIButton()
        btn.setImage(BundleTool.getImage(str: "arrow"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: textfiled.frame.size.height)
        textfiled.rightViewMode = .always
        textfiled.rightView = btn
        
        textfiled.addTarget(self, action: #selector(valuechanged(_:)), for: .editingChanged)
        
    }

    @objc func valuechanged(_ textfiled:UITextField){
        if let block = textChangeBlock {
            block(textfiled.text)
        }
    }
    
    
    
}
