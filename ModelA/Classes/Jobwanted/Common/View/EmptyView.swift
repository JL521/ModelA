//
//  EmptyView.swift
//  NVRCloudIOS
//
//  Created by Nvr on 2018/9/27.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var noDataTitle: UILabel!
    @IBOutlet weak var functionBtn: UIButton!
    
    var funcCallBack:NoParamCallBack = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        functionBtn.layer.cornerRadius = 5
        functionBtn.layer.masksToBounds = true
    }

    @IBAction func functionBtnClick(_ sender: Any) {
        if let callBack = funcCallBack{
            callBack()
        }
    }
    
    func reloadView(image: UIImage? = BundleTool.getImage(str: "nodata"), title: String? = "暂无数据哦~",btnTitle:String? = nil,functionCallBack:NoParamCallBack = nil){
        noDataImageView.image = image
        noDataTitle.text      = title
        if btnTitle != nil {
            functionBtn.isHidden = false
            funcCallBack = functionCallBack
        }
    }
}
