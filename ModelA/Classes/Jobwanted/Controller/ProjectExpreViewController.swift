//
//  ProjectExpreViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/14.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class ProjectExpreViewController: JobWantBaseViewController {

    var titles:[String]?
    var tab:UITableView!
    var dispoase = DisposeBag()
    var proModel:projectExpreModel?
    
    var proName:String?
    var prostartTime:String?
    var proEndTime:String?
    var proPosition:String?
    var proDesc:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "项目经验"
        titles = ["项目名称","开始时间","结束时间","担任职位","项目描述"]
        if proModel != nil {
            proName = proModel?.projectName
            prostartTime = proModel?.startTime
            proEndTime = proModel?.endTime
            proPosition = proModel?.positionName
            proDesc = proModel?.projectDesc
        }
        setTabviewUI()
    }
}

extension ProjectExpreViewController{
    
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


extension ProjectExpreViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row==4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineEditResumeTextViewCell") as! MineEditResumeTextViewCell
            cell.namel.text = "项目描述"
            cell.setText(str: proDesc)
            cell.textChangeBlock = {
                (str : String?)->() in
                self.proDesc = str
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
            cell.textfiled.text = proName
            cell.textChangeBlock = {
                (str:String?)->() in
                self.proName = str
            }
        }
        if indexPath.row==1 {
            cell.textfiled.text = prostartTime
        }
        if indexPath.row==2 {
            cell.textfiled.text = proEndTime
        }
        if indexPath.row==3 {
            cell.textfiled.rightView = nil
            cell.textfiled.isUserInteractionEnabled = true
            cell.textfiled.text = proPosition
            cell.textChangeBlock = {
                (str:String?)->() in
                self.proPosition = str
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==1 {
            let pickView = TQDatePickerView(type: .KDatePickerDate)
            pickView.sucessReturnB = { (date: String) in
                self.prostartTime = date
                self.tab.reloadData()
            }
            pickView.show()
        }
        if indexPath.row==2 {
            let pickView = TQDatePickerView(type: .KDatePickerDate)
            pickView.sucessReturnB = { (date: String) in
                self.proEndTime = date
                self.tab.reloadData()
            }
            pickView.show()
        }
    }
    
}

extension ProjectExpreViewController{
    
    @objc func save() {
        
        if proName?.isEmpty ?? true{
            showToast(info: "请输入项目名称")
            return
        }
        
        if proPosition?.isEmpty ?? true{
            showToast(info: "请输入担任职务")
            return
        }
        
        if prostartTime?.isEmpty ?? true{
            showToast(info: "请选择开始时间")
            return
        }
        
        if proEndTime?.isEmpty ?? true{
            showToast(info: "请选择结束时间")
            return
        }
        
        var parm = ["projectName":proName ?? "","positionName":proPosition ?? "","startTime": prostartTime ?? "","endTime": proEndTime ?? "","projectDesc":proDesc ?? ""] as [String : Any]
        var request:JobWantReqAPI = .addProjectExperience(parm)
        if proModel != nil {
            parm["id"] = proModel?.id
            request = .updateProjectExperience(parm)
        }
        
        DispatchQueue.main.async {
            Activity.shared.dismiss()
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
