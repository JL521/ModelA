//
//  BusiInviteMSViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class BusiInviteMSViewController: JobWantBaseViewController {

    var titles:[[String]]?
    var tab:UITableView!
    var dispoase = DisposeBag()
    
    var model :BussRecivedResumeModel?
    var findmodel :BussFindPeopleModel?
    var detailModel:BusiResumeDetaiModel?
    
    var address:String?
    var offertime:String?
    
    var lxr:String?
    var lxfs:String?
    
    var msginfo:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "确认面试通知"
        titles = [["面试公司","面试职位"],["面试地点","面试时间"],["联系人","联系方式"],["注意事项"]]
        setTabviewUI()
    }
}

extension BusiInviteMSViewController{
    
    func setTabviewUI() {

        tab = UITableView(frame: self.view.bounds, style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        let hv = UIView()
        hv.frame = CGRect(x: 0, y: 0, width: 0, height: 0.1)
        tab.tableHeaderView = hv
        
        let nib = UINib(nibName: "MineResumeAddUITableViewCell", bundle: BundleTool.getBundle())
        tab.register(nib, forCellReuseIdentifier: "MineResumeAddUITableViewCell")
        
        let MineEditResumeTextViewCell = UINib(nibName: "MineEditResumeTextViewCell", bundle: BundleTool.getBundle())
        tab.register(MineEditResumeTextViewCell, forCellReuseIdentifier: "MineEditResumeTextViewCell")
        
        tab.estimatedRowHeight=40
        tab.tableFooterView = UIView()
        tab.separatorStyle = .none
        tab.backgroundColor = .clear
        tab.showsVerticalScrollIndicator = false
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)

        let fv = UIView()
        fv.frame = CGRect(x: 0, y: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height, width: self.view.frame.size.width, height: 74)
        fv.backgroundColor = .white
        view.addSubview(fv)
        
        let btn = UIButton()
        btn.setTitle("发送", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
        btn.frame = CGRect(x: 16, y: 14, width: fv.frame.size.width-32, height: 74-14*2)
        fv.addSubview(btn)
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
}


extension BusiInviteMSViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = titles?[section]
        return arr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineEditResumeTextViewCell") as! MineEditResumeTextViewCell
            cell.namel.text = "注意事项"
            cell.setText(str: msginfo)
            cell.descl.text = "请输入面试时需要注意的事项"
            cell.textChangeBlock = {
                (str : String?)->() in
                self.msginfo = str
            }
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineResumeAddUITableViewCell") as! MineResumeAddUITableViewCell
        let arr = titles?[indexPath.section]
        cell.titll.text = arr?[indexPath.row]
        cell.textfiled.placeholder = "请选择"
        cell.textfiled.isUserInteractionEnabled = false
        cell.textfiled.tag = indexPath.row
        
        if indexPath.section==0 {
            cell.textfiled.rightView = nil
            if indexPath.row == 0 {
                cell.textfiled.text = detailModel?.companyName
            }
            if indexPath.row == 1 {
                cell.textfiled.text = detailModel?.jobName
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row==0 {
                cell.textfiled.rightView = nil
                cell.textfiled.isUserInteractionEnabled = true
                cell.textfiled.text = address
                cell.textChangeBlock = {
                    (str:String?)->() in
                    self.address = str
                }
            }
            if indexPath.row==1 {
                cell.textfiled.text = offertime
            }
            
        }
        
        if indexPath.section == 2 {
            if indexPath.row==0 {
                cell.textfiled.rightView = nil
                cell.textfiled.isUserInteractionEnabled = true
                cell.textfiled.text = lxr
                cell.textChangeBlock = {
                    (str:String?)->() in
                    self.lxr = str
                }
            }
            if indexPath.row==1 {
                cell.textfiled.rightView = nil
                cell.textfiled.isUserInteractionEnabled = true
                cell.textfiled.text = lxfs
                cell.textChangeBlock = {
                    (str:String?)->() in
                    self.lxfs = str
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            let pickView = TQDatePickerView(type: .KDatePickerTime)
            pickView.sucessReturnB = { (date: String) in
                self.offertime = date
                self.tab.reloadData()
             }
            pickView.show()
        }
        
    }
    
}

extension BusiInviteMSViewController{
    
    @objc func save() {
        
        if address?.isEmpty ?? true {
            showToast(info: "请输入面试地点")
            return;
        }
        
        if offertime?.isEmpty ?? true {
            showToast(info: "请选择面试时间")
            return;
        }
        
        if lxr?.isEmpty ?? true {
            showToast(info: "请输入联系人")
            return;
        }
        
        if lxfs?.isEmpty ?? true {
            showToast(info: "请输入联系方式")
            return;
        }
        
        var parm = ["id" : model?.jobId ?? "","userId": model?.userId ?? "","userName":model?.userName ?? "","jobName":detailModel?.jobName ?? "","workyears":address ?? "","interviewTime":offertime ?? "" , "contate": lxr ?? "" ] as [String : Any]
        parm["phone"] =  lxfs ?? ""
        parm["attention"] =  msginfo ?? ""
        parm["onlyId"] =  model?.id ?? ""
        parm["companyName"] =  detailModel?.companyName ?? ""
        
        if let mo = model {
            parm["onlyId"] = mo.id ?? ""
            parm["id"] = mo.jobId ?? ""
            parm["userId"] = mo.userId ?? ""
            parm["userName"] = mo.userName ?? ""
        }else if let mod = findmodel {
            parm["onlyId"] = mod.id ?? ""
            parm["id"] = mod.positionId ?? ""
            parm["userId"] = mod.userId ?? ""
            parm["userName"] = mod.userName ?? ""
        }
        
        
        
        let request:JobWantReqAPI = .addinit(parm)
        
        
        DispatchQueue.main.async {
            Activity.shared.show()
        }
               JobRequestAPIProvider.rx.request(request).mapJSON().subscribe(onSuccess: { (value) in
                   print(value)
                
                DispatchQueue.main.async {
                    Activity.shared.dismiss()
                }
                
                   let json = value as! [String:Any]
                print(json)
                   let code = json["code"] as? String
                if let cd = code {
                    if cd == "0"{
                    Alert.shared.showAlert(title: "提示", content: "已发送面试通知请等待对方确认", containBtnTitle: "确定") {
                        
                    }
                    self.navigationController?.popViewController(animated: true)
                    }
                    
                }
                   
               }) { (error) in
                DispatchQueue.main.async {
                    Activity.shared.dismiss()
                }
                   
               }.disposed(by: dispoase)
        
    }
    
}

