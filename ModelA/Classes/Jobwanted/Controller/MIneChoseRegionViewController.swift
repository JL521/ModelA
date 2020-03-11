//
//  MIneChoseRegionViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/13.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

enum PICKVIEWYPE {
    case hangye
    case zhiye
    case yuexin
    case hziye_status
    case eduxueli
    case eduxuewei
    case experience
}


class MIneChoseRegionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var pivkV: UIPickerView!
    var type : PICKVIEWYPE?
    var dispoase = DisposeBag()
    var dataArr : [MinePickModel]?
    var selPickModel : MinePickModel?
    var doneBlcok:((_ model:MinePickModel) -> Void)?
    var index:Int!
    var dataModel:MinePickModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = 0
        self.pivkV.delegate = self
        self.pivkV.dataSource = self
    }
    @IBAction func cancle(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func sure(_ sender: UIButton) {
        
        if dataArr != nil {
            selPickModel = dataArr?[index]
            self.doneBlcok!(selPickModel!)
        }
        self.dismiss(animated: false, completion: nil)
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let model = dataArr?[row]
        return model?.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }

}


extension MIneChoseRegionViewController{
    
    func getDataSource(type:PICKVIEWYPE) {
        dataArr = []
        switch type {
        case .hangye:
            getIndustries()
            break
        case .zhiye:
            getPositions()
            break
        case .yuexin:
            getYuexin()
            break
        case .hziye_status:
            getzhiyestatus()
            break
        case .eduxueli:
            geteduxueli()
            break
        case .eduxuewei:
            geteduxuewei()
            break
        case .experience:
            getexperience()
            break
        }
    }
    
    func getIndustries() {
        JobRequestAPIProvider.rx.request(.getIndustries).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["id"] as? Int
                model.name = dic["industryName"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)

    }
    
    func getPositions() {
        
           let parm = ["industryId":dataModel?.id ?? ""] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getPositions(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["id"] as? Int
                model.name = dic["positionName"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
    
    func getYuexin() {
        
           let parm = ["typeCode":"salary"] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getYuexin(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["value"] as? Int
                model.name = dic["name"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
    
    func getzhiyestatus() {
        
           let parm = ["typeCode":"job_status"] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getYuexin(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["value"] as? Int
                model.name = dic["name"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
    
    func geteduxueli() {
        
           let parm = ["typeCode":"education"] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getYuexin(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["value"] as? Int
                model.name = dic["name"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
    
    func geteduxuewei() {
        
           let parm = ["typeCode":"degree"] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getYuexin(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["value"] as? Int
                model.name = dic["name"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
    
    func getexperience() {
        
           let parm = ["typeCode":"experience"] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getYuexin(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            let json = value as! [String:Any]
            let arr = json["result"] as! [[String:Any]]
            self.dataArr?.removeAll()
            for dic in arr{
                let model = MinePickModel()
                model.id = dic["value"] as? Int
                model.name = dic["name"] as? String
                self.dataArr?.append(model)
            }
            self.pivkV.reloadAllComponents()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
    
}


