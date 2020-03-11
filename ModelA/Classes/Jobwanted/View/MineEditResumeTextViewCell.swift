//
//  MineEditResumeTextViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/14.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class MineEditResumeTextViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var namel: UILabel!
    @IBOutlet weak var countl: UILabel!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var descl: UILabel!
    var count:Int?
    var textChangeBlock:((_ str:String?)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        textview.layer.borderColor = UIColor.init(hex: 0xAEB5C5).cgColor
        textview.layer.borderWidth = 1
        textview.layer.cornerRadius = 8
        textview.layer.masksToBounds = true
        
        textview.delegate = self
    
        count = 2000
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return range.location < count ?? 0
    }

    func textViewDidChange(_ textView: UITextView) {
               
        if textView.text.count == 0 {
            descl.isHidden = false
        }else{
            descl.isHidden = true
        }
        if let block = textChangeBlock {
            block(textView.text)
        }
        countl.text = "\(textView.text.count)/\(count ?? 0)"

    }
    
    func setCount(count:Int) {
        countl.text = "\(0)/\(count)"
    }
 
    func setText(str:String?){
        textview.text = str
        descl.isHidden = true
        if str == nil || str?.count == 0 {
            descl.isHidden = false
        }
        countl.text = "\(textview.text.count)/\(count ?? 0)"
    }
    
}
