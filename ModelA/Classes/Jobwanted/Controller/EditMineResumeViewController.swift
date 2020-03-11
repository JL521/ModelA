//
//  EditMineResumeViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/13.
//  Copyright © 2020 zhangyu. All rights reserved.
//

/**
 求职意向
 */

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class EditMineResumeViewController: JobWantBaseViewController {

    var tab:UITableView!
    var titles:[String]?
    var dispoase = DisposeBag()
    var resumeModel:MineResumeModel?
    
    var hangyeModel:MinePickModel?
    var zhiyeModel:MinePickModel?
    var yuexinModel:MinePickModel?
    var statusModel:MinePickModel?
    
    var provice:String?
    var city:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titles = ["期望工作地点","期望从事行业","期望从事职业","期望税前月薪","当前求职状态"]
        self.title = "求职意向"
        
        if resumeModel != nil {
            hangyeModel = MinePickModel()
            hangyeModel?.id = resumeModel?.industryId
            hangyeModel?.name = resumeModel?.industryName
            
            zhiyeModel = MinePickModel()
            zhiyeModel?.id = resumeModel?.positionId
            zhiyeModel?.name = resumeModel?.positionName
            
            yuexinModel = MinePickModel()
            yuexinModel?.id = resumeModel?.salaryId
            yuexinModel?.name = resumeModel?.salary
            
            statusModel = MinePickModel()
            statusModel?.id = resumeModel?.jobStatusId
            statusModel?.name = resumeModel?.jobStatus
            
            provice = resumeModel?.province
            city = resumeModel?.city

        }
        
        setTabviewUI()
        
    }
    
}

extension EditMineResumeViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let nib = UINib(nibName: "MineResumeAddUITableViewCell", bundle: BundleTool.getBundle())
        tab.register(nib, forCellReuseIdentifier: "MineResumeAddUITableViewCell")
        tab.estimatedRowHeight=40
        tab.tableFooterView = UIView()
        tab.separatorStyle = .none
        tab.backgroundColor = .clear
        tab.showsVerticalScrollIndicator = false
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let fv = UIView()
        fv.frame = CGRect(x: 0, y: 0, width: tab.frame.size.width, height: 100)
        fv.backgroundColor = .clear
        tab.tableFooterView = fv
        
        let btn = UIButton()
        btn.setTitle("保存", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
        btn.frame = CGRect(x: 20, y: 40, width: tab.frame.size.width-40, height: 40)
        fv.addSubview(btn)
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)

    }
}


extension EditMineResumeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineResumeAddUITableViewCell") as! MineResumeAddUITableViewCell
        cell.titll.text = titles?[indexPath.row]
        
        cell.textfiled.placeholder = "请选择"
        cell.textfiled.isUserInteractionEnabled = false
        cell.textfiled.tag = indexPath.row
        
        if indexPath.row==0 {
            cell.textfiled.text = (provice ?? "") + (city ?? "")
        }
        if indexPath.row==1 {
            cell.textfiled.text = hangyeModel?.name

        }
        if indexPath.row==2 {
            cell.textfiled.text = zhiyeModel?.name
        }
        if indexPath.row==3 {
            cell.textfiled.text = yuexinModel?.name
        }
        if indexPath.row==4 {
            cell.textfiled.text = statusModel?.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        if indexPath.row == 0 {
            getLocation()
        }
        if indexPath.row==1 {
            gethangye()
        }
        if indexPath.row==2 {
            getzhiye()
        }
        if indexPath.row==3 {
            getYuexin()
        }
        if indexPath.row==4 {
            getstatus()
        }
        
    }
}


extension EditMineResumeViewController{
    
    @objc func save() {
        
        if provice?.isEmpty ?? true {
            showToast(info: "请选择期望工作地点")
            return;
        }
        
        if hangyeModel?.name?.isEmpty ?? true {
            showToast(info: "请选择期望行业")
            return;
        }
        
        if zhiyeModel?.name?.isEmpty ?? true {
            showToast(info: "请选择期望职位")
            return;
        }
        
        if yuexinModel?.name?.isEmpty ?? true {
            showToast(info: "请选择期望薪资")
            return;
        }
        
        if statusModel?.name?.isEmpty ?? true {
            showToast(info: "请选择求职状态")
            return;
        }
        
        
        let parm = ["province":provice ?? "","city":city ?? "","industryId":hangyeModel?.id ?? "0","positionId":zhiyeModel?.id ?? "0","salaryId":yuexinModel?.id ?? "0","jobStatusId":statusModel?.id ?? "0","attachment":""] as [String : Any]
               
              
       DispatchQueue.main.async {
           Activity.shared.show()
       }
        JobRequestAPIProvider.rx.request(.saveYXZW(parm)).mapJSON().subscribe(onSuccess: { (value) in
                   print(value)
                DispatchQueue.main.async {
                    Activity.shared.dismiss()
                }
                
                   let json = value as! [String:Any]
                print(json)
                   let code = json["code"] as? String
                if let cd = code {
                if cd == "0"{
                    showToast(info: "保存成功")
                    self.navigationController?.popViewController(animated: true)
                    }
                    
                }
                   
               }) { (error) in
                DispatchQueue.main.async {
                    Activity.shared.dismiss()
                }
                   
               }.disposed(by: dispoase)
        
    }
    
    func gethangye() {
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .hangye)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            if self.hangyeModel?.id != model.id {
                self.zhiyeModel = nil
            }
            self.hangyeModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    func getzhiye() {
        
        if hangyeModel == nil {
            showToast(info: "请先选择行业")
            return
        }
        
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.dataModel = hangyeModel
        vc.getDataSource(type: .zhiye)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.zhiyeModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    func getYuexin() {
        
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .yuexin)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.yuexinModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    func getstatus() {
        
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .hziye_status)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.statusModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }

    func getLocation() {
        let svc = MineSelectRegionControllerViewController(nibName: "MineSelectRegionControllerViewController", bundle: BundleTool.getBundle())
        svc.modalPresentationStyle = .custom
        svc.doneBlcok = {
            (proModel:RegionModel?,cityModel:RegionModel?,quModel:RegionModel?) in
            self.provice = proModel?.title ?? ""
            self.city = cityModel?.title ?? ""
            self.tab.reloadData()
        }
        self.present(svc, animated: false, completion: nil)
    }
    
}

