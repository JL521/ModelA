//
//  ViewController.swift
//  ModelA
//
//  Created by JL521 on 03/10/2020.
//  Copyright (c) 2020 JL521. All rights reserved.
//

import UIKit
import ModelA

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let stob = UIStoryboard.init(name: "Jobwanted", bundle: BundleTool.getBundle())

        let vc = stob.instantiateViewController(withIdentifier: "JobWantListControllerViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

