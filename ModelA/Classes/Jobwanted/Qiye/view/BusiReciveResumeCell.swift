//
//  BusiReciveResumeCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class BusiReciveResumeCell: UITableViewCell {

    @IBOutlet weak var namel: UILabel!
    @IBOutlet weak var moneyl: UILabel!
    @IBOutlet weak var headimgv: UIImageView!
    @IBOutlet weak var addressl: UILabel!
    @IBOutlet weak var usernamel: UILabel!
    @IBOutlet weak var sjview: UIView!
    @IBOutlet weak var sjl: UILabel!
    var tapBlock:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        self.contentView.layer.cornerRadius = 6
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        
        self.moneyl.isUserInteractionEnabled = true
        
        let tp = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        moneyl.addGestureRecognizer(tp)
    }

    func setDataWithModel(mode:BussRecivedResumeModel?) {
        
        if  let model = mode {
            namel.text = model.positionName
            moneyl.text = "\(model.money ?? 0)"
            usernamel.text = model.userName
            addressl.text = "\(model.workingSpace ?? "") | \(model.education ?? "") | \(model.workTime ?? "")年"
            sjl.text = "评估身价：\(model.money ?? 0)万"
        }
        
    }
    
    func setBusFindPeopleDataWithModel(mode:BussFindPeopleModel?) {
        if  let model = mode {
            namel.text = model.positionName
            moneyl.text = "\(model.money ?? "0")"
            usernamel.text = model.userName
            addressl.text = "\(model.workingSpace ?? "") | \(model.education ?? "") | \(model.workYears ?? "")年"
            sjl.text = "评估身价：\(model.sjScore ?? "0")万"
        }
    }
    
    func setBusiRecivedResumeDataWithModel(mode:BussRecivedResumeModel?) {
        
        print("企业收到的简历 身价 \(mode?.money ?? 0)")
        
        if  let model = mode {
            namel.text = model.positionName
            moneyl.text = "\(model.moneys ?? "0")"
            usernamel.text = model.userName
            addressl.text = "\(model.workingSpace ?? "") | \(model.education ?? "") | \(model.workTime ?? "")年"
            sjl.text = "评估身价：\(model.money ?? 0)万"
        }
        
    }
    
    @objc func tap(_ tp :UITapGestureRecognizer){
        if let tpb = tapBlock{
            tpb()
        }
    }
    
}
