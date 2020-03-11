//
//  BusiPublishSuccessViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class BusiPublishSuccessViewController: JobWantBaseViewController {

    @IBOutlet weak var bacnBTn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        bacnBTn.layer.borderWidth = 1
        bacnBTn.layer.borderColor = UIColor.init(hex: 0x2F6AFF).cgColor
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.backBarButtonItem = nil
        self.navigationItem.hidesBackButton = true;
        view.backgroundColor = .white
        
    }

    @IBAction func publish(_ sender: UIButton) {
        let vc = BusiPublishJobViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func goback(_ sender: Any) {
        
        for vc in self.navigationController!.viewControllers {
            if vc.isKind(of: BusiJobManagerViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }else if vc.isKind(of: BusiFindPeopleViewController.self){
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
        
    }
    
}
