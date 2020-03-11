//
//  FJresumeCollectionViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/16.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class FJresumeCollectionViewCell: UICollectionViewCell {

    var block : (()->())?
    @IBOutlet weak var delbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        delbtn.isHidden = true
    }

    @IBAction func del(_ sender: UIButton) {
        if let myb = block{
            myb()
        }
    }
}
