//
//  MineSelectRegionControllerViewController.swift
//  Rencaiyoujia
//
//  Created by 姜磊 on 2020/2/11.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

enum ReginType {
    case provice
    case city
    case qu
}

class MineSelectRegionControllerViewController: UIViewController {

    var dispoase = DisposeBag()
    var proArr : [RegionModel]?
    var cityArr : [RegionModel]?
    var quArr : [RegionModel]?
    var proIndex:Int!
    var cityIndex:Int!
    var quIndex:Int!
    
    var type : ReginType?
    
    var proModel:RegionModel?
    var cityModel:RegionModel?
    var quModel:RegionModel?
    
    var doneBlcok:((_ proModel : RegionModel?,_ cityModle:RegionModel?,_ quModel:RegionModel?)->())?
    var proIndexBlock:((_ proIndex : Int?)->())?
    var cityIndexBlock:((_ cityIndex : Int?)->())?
    
    var component : Int?
    var selectProIndex : Int?
    var selectCityIndex : Int?
    var province : String?
    
    @IBOutlet weak var pickView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        proIndex = 0
        cityIndex = 0
        quIndex = 0
        
        pickView.delegate = self
        pickView.dataSource = self
        
        getLocation()
        
        
    }

    @IBAction func btnclick(_ sender: UIButton) {
        if sender.tag == 1 {
            if let myb = doneBlcok{
                myb(proModel,cityModel,quModel)
            }
            if let myb = proIndexBlock {
                myb(proIndex)
            }
            if let myb = cityIndexBlock {
                myb(cityIndex)
            }
        }
        dismiss(animated: false, completion: nil)
    }
    
   func getLocation() {
       
    Activity.shared.show()
    JobRequestAPIProvider.rx.request(.getRegion).mapObject(BaseArrayModel<RegionModel>.self).subscribe(onSuccess: { (value) in
        
        Activity.shared.dismiss()
        
           let resuModelArr = value.result
           self.proArr = resuModelArr
           self.proIndex = self.selectProIndex ?? 0
        
        if let pro = self.province {
        for item in resuModelArr ?? [] {
            if item.title?.range(of: "\(pro)") != nil{
                self.proModel = item;
                self.cityIndex = self.selectCityIndex ?? 0
                break;
            }
        }
        }
    
        
        self.setData()
          
           
       }) { (error) in
           Activity.shared.dismiss()
       }.disposed(by: dispoase)
       
   }
    
    func setData() {
        
        
        cityModel = nil
        quModel = nil
        cityArr = []
        quArr = []
        
        if province == nil {
        proModel = nil
        let pmodel = proArr?[proIndex]
        cityArr = pmodel?.child
        proModel = pmodel
            
        }else{
            cityArr = proModel?.child
        }
        
        
        if cityArr?.count ?? 0 > 0 {
            let cmodel = cityArr?[cityIndex]
            quArr = cmodel?.child
            cityModel = cmodel
        }
        
        
        
        if quArr?.count ?? 0 > 0 {
            quModel = quArr?[quIndex]
        }
        
        
        
        pickView.reloadAllComponents()
        if component ?? 0 > 1 {
            pickView.selectRow(cityIndex, inComponent: 1, animated: true)
        }
        
        if component ?? 0 > 2 {
        pickView.selectRow(quIndex, inComponent: 2, animated: true)
        }
        
        if type == ReginType.provice {
            pickView.selectRow(proIndex, inComponent: 0, animated: true)
        }else if type == ReginType.city {
            pickView.selectRow(cityIndex, inComponent: 0, animated: true)
        }
        
    }

}

extension MineSelectRegionControllerViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return component ?? 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if type == ReginType.provice {
            return proArr?.count ?? 0
        }
        
        if type == ReginType.city {
            return cityArr?.count ?? 0
        }
        
        if type == ReginType.qu {
            return quArr?.count ?? 0
        }
        
        
        if component == 0 {
            return proArr?.count ?? 0
        }
        
        if component == 1 {
            return cityArr?.count ?? 0
        }
        
        if component == 2 {
            return quArr?.count ?? 0
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if type == ReginType.provice {
            let model = proArr?[row]
            return model?.title ?? ""
        }
        
        if type == ReginType.city {
           let model = cityArr?[row]
            return model?.title ?? ""
        }
        
        if type == ReginType.qu {
           let model = quArr?[row]
            return model?.title ?? ""
        }
        
         if component == 0 {
            let model = proArr?[row]
            return model?.title ?? ""
        }
               
        if component == 1 {
            let model = cityArr?[row]
            return model?.title ?? ""
        }
               
        if component == 2 {
            let model = quArr?[row]
            return model?.title ?? ""
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if type == ReginType.city {
                cityIndex = row
                quIndex = 0
                setData()
            }else if type == ReginType.provice{
            proIndex = row
            cityIndex = 0
            quIndex = 0
            setData()
                
            }else if type == ReginType.qu{
            quIndex = row
            setData()
            }else{
                proIndex = row
                cityIndex = 0
                quIndex = 0
                setData()
            }
        }
        if component == 1 {
            cityIndex = row
            quIndex = 0
            setData()
        }
        if component == 2 {
            quIndex = row
            setData()
        }
    }
    
    
}
