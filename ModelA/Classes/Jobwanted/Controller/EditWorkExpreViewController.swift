//
//  EditWorkExpreViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/14.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class EditWorkExpreViewController: JobWantBaseViewController {

    var titles:[String]?
    var tab:UITableView!
    var dispoase = DisposeBag()
    var workModel:workExpreModel?
    
    var companyName:String?
    var jobName:String?
    var ruzhitime:String?
    var lizhitime:String?
    var workdesc:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "工作经验"
        titles = ["公司名称","职位名称","入职时间","离职时间","工作描述"]
        if workModel != nil {
            companyName = workModel?.companyName
            jobName = workModel?.positionName
            ruzhitime = workModel?.entryTime
            lizhitime = workModel?.leaveTime
            workdesc = workModel?.jobDesc
        }
        setTabviewUI()
    }
}

extension EditWorkExpreViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let nib = UINib(nibName: "MineResumeAddUITableViewCell", bundle: BundleTool.getBundle())
        tab.register(nib, forCellReuseIdentifier: "MineResumeAddUITableViewCell")
        
        let MineEditResumeTextViewCell = UINib(nibName: "MineEditResumeTextViewCell", bundle: BundleTool.getBundle())
        tab.register(MineEditResumeTextViewCell, forCellReuseIdentifier: "MineEditResumeTextViewCell")
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
}


extension EditWorkExpreViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row==4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineEditResumeTextViewCell") as! MineEditResumeTextViewCell
            cell.namel.text = "工作描述"
            cell.setText(str: workdesc)
            cell.textChangeBlock = {
                (str : String?)->() in
                self.workdesc = str
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineResumeAddUITableViewCell") as! MineResumeAddUITableViewCell
        cell.titll.text = titles?[indexPath.row]
        cell.textfiled.placeholder = "请选择"
        cell.textfiled.isUserInteractionEnabled = false
        cell.textfiled.tag = indexPath.row
        
        if indexPath.row==0 {
            cell.textfiled.rightView = nil
            cell.textfiled.isUserInteractionEnabled = true
            cell.textfiled.text = companyName
            cell.textChangeBlock = {
                (str:String?)->() in
                self.companyName = str
            }
        }
        if indexPath.row==1 {
            cell.textfiled.rightView = nil
            cell.textfiled.isUserInteractionEnabled = true
            cell.textfiled.text = jobName
            cell.textChangeBlock = {
                (str:String?)->() in
                self.jobName = str
            }
        }
        
        if indexPath.row==2 {
            cell.textfiled.text = ruzhitime
        }
        if indexPath.row==3 {
            cell.textfiled.text = lizhitime
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==2 {
            let pickView = TQDatePickerView(type: .KDatePickerDate)
            pickView.sucessReturnB = { (date: String) in
                self.ruzhitime = date
                self.tab.reloadData()
             }
            pickView.show()
        }
        if indexPath.row==3 {
            let pickView = TQDatePickerView(type: .KDatePickerDate)
            pickView.sucessReturnB = { (date: String) in
                self.lizhitime = date
                self.tab.reloadData()
             }
            pickView.show()
        }
    }
    
}

extension EditWorkExpreViewController{
    
    @objc func save() {
        
        if companyName?.isEmpty ?? true {
            showToast(info: "请输入公司名称")
            return;
        }
        
        if jobName?.isEmpty ?? true {
            showToast(info: "请输入职位名称")
            return;
        }
        
        if ruzhitime?.isEmpty ?? true{
            showToast(info: "请选择入职时间")
            return
        }
        
        if lizhitime?.isEmpty ?? true{
            showToast(info: "请选择离职时间")
            return
        }
        
        
        var parm = ["companyName":companyName ?? "","positionName":jobName ?? "","entryTime": ruzhitime ?? "","leaveTime": lizhitime ?? "","jobDesc":workdesc ?? ""] as [String : Any]
        var request:JobWantReqAPI = .addWorkExperience(parm)
        if workModel != nil {
            parm["id"] = workModel?.id
            request = .updateWorkExperience(parm)
        }
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
    
}
