//
//  AlertView.swift
//
//  Created by Nvr on 2018/3/15.
//  Copyright © 2018年 ZY. All rights reserved.
//


import UIKit

typealias AlertClickCallBack = (_ Flag: Bool) -> Void

class AlertView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!

    var globalCallBack: AlertClickCallBack?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func showInView(view: UIView, title: String?="提示", content: String?, leftBtnTitle: String = "否", rightBtnTitle: String = "是", callBack:@escaping AlertClickCallBack) {
        globalCallBack = callBack
        titleLabel.text = title
        contentLabel.text = content
        leftBtn.setTitle(leftBtnTitle, for: .normal)
        rightBtn.setTitle(rightBtnTitle, for: .normal)
        self.frame = view.bounds
        view.addSubview(self)
    }

    @IBAction func cancelBtnClick(_ sender: UIButton) {
        globalCallBack!(false)
        self.removeFromSuperview()
    }

    @IBAction func containBtnClick(_ sender: UIButton) {
        globalCallBack!(true)
        self.removeFromSuperview()
    }
}
