//
//  JobResumeTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/8.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class JobResumeTableViewCell: UITableViewCell {
    @IBOutlet weak var posil: UILabel!
    @IBOutlet weak var moneyl: UILabel!
    @IBOutlet weak var qysjl: UILabel!
    @IBOutlet weak var companyl: UILabel!
    @IBOutlet weak var sjview: UIView!
    @IBOutlet weak var desl: UILabel!
    @IBOutlet weak var busjobeditbtn: UIButton!
    var tapBlock:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.contentView.layer.cornerRadius = 6
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        
        self.moneyl.isUserInteractionEnabled = true
        
        let tp = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        moneyl.addGestureRecognizer(tp)
        
    }

    func setDataWithModel(mode:MineJobModel?) {
        if let model = mode{
            
            posil.text = model.jobName
            moneyl.text = model.salary
            qysjl.text = "企业身价：\(model.sjScore ?? 0)万" 
            companyl.text = model.companyName
            desl.text = "\(model.site ?? "") | \(model.education ?? "") | \(model.workyears ?? "")"
            
        }
    }
    
    func setBusiDataWithModel(mode:MineJobModel?) {
        if let model = mode{
            
            posil.text = model.jobName
            moneyl.text = model.salary
            qysjl.text = ""
            sjview.isHidden = true
            companyl.text = model.companyName
            desl.text = "\(model.site ?? "") | \(model.education ?? "") | \(model.workyears ?? "")"
            
        }
    }
    
    func setDetailDataWithModel(mode:MineJobModel?) {
        if let model = mode{
            
            posil.text = model.jobName
            moneyl.text = model.salary
            qysjl.text = ""
            sjview.isHidden = true
            companyl.text = "\(model.site ?? "") | \(model.education ?? "") | \(model.workyears ?? "")"
            desl.text = "招聘人数：\(model.jobNumber ?? 0)人"
            
        }
    }
    
    @objc func tap(_ tp :UITapGestureRecognizer){
        if let tpb = tapBlock{
            tpb()
        }
    }
    @IBAction func edit(_ sender: UIButton) {
        if let tpb = tapBlock{
            tpb()
        }
    }
    
}
