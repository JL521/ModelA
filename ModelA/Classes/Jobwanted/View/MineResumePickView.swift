//
//  MineResumePickView.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/13.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class MineResumePickView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var pickView:UIPickerView!
    
    var type:Int?
    
    var dataArr:[IndustriesModel]?
    var dispoase = DisposeBag()
    var seletModel:IndustriesModel?
    
    
    var posModel:IndustriesModel?
    var doneBlcok:((_ model:IndustriesModel?) -> Void)?
    var doneposBlcok:((_ model:IndustriesModel?) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            pickView = UIPickerView(frame: frame)
            pickView.delegate = self
            pickView.dataSource = self
            self.addSubview(pickView)
        self.backgroundColor = .white
           
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataArr?.count ?? 0
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        switch type {
        case 1:
            let model = dataArr?[row]
            return model?.industryName
        case 2:
            let model = dataArr?[row]
            return model?.positionName
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        doneRload(row: row)
        
        
    }
    
}

extension MineResumePickView{
    
    public func reloadData(row:Int) {
        type = row
        if row==1 {
            getIndustries()
        }else if row==2{
            getPositions()
        }
    }
    
    func doneRload(row:Int) {

        switch type {
        case 1:
            let model = dataArr?[row]
            doneBlcok!(model)
        case 2:
            let model = dataArr?[row]
            doneposBlcok!(model)
        default:
            break
        }

    }
    
    func getIndustries() {
            
       
       
        JobRequestAPIProvider.rx.request(.getIndustries).mapJSON().subscribe(onSuccess: { (value) in
            
            let arr = JSON(value)["result"]
            print(arr)
            
            
        }) { (error) in
            
        }.disposed(by: dispoase)
    }
    
    func getPositions() {
        
           let parm = ["industryId":posModel?.id ?? ""] as [String : Any]
        
        JobRequestAPIProvider.rx.request(.getPositions(parm)).mapObject(BaseArrayModel<IndustriesModel>.self).subscribe(onSuccess: { (value) in
            
            let arr = value.result
            self.dataArr = arr
            self.pickView.reloadAllComponents()
            self.doneRload(row: 0)
            
        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
}
