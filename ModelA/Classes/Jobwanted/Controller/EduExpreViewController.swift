//
//  EduExpreViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/14.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class EduExpreViewController: JobWantBaseViewController {

    var titles:[String]?
    var tab:UITableView!
    var dispoase = DisposeBag()
    var eduModel:MineEduModel?
    
    var schoolName:String?
    var zhuanye:String?
    var readtime:String?
    var biyetime:String?
    var isTZ:String?
    var xueliModel:MinePickModel?
    var xueweiModel:MinePickModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "教育经历"
        titles = ["学校名称","学历","学位","所学专业","就读时间","毕业时间","是否统招"]
        isTZ = "1"
        if eduModel != nil {
            schoolName = eduModel?.schoolName
            xueliModel = MinePickModel()
            xueliModel?.id = eduModel?.educationId
            xueliModel?.name = eduModel?.education
            xueweiModel = MinePickModel()
            xueweiModel?.id = eduModel?.degreeId
            xueweiModel?.name = eduModel?.degree
            zhuanye = eduModel?.major
            readtime = eduModel?.studyTime
            biyetime = eduModel?.graduateTime
            isTZ = eduModel?.unifiedEnroll == true ? "1":"0"
        }
        setTabviewUI()
    }
}

extension EduExpreViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let nib = UINib(nibName: "MineResumeAddUITableViewCell", bundle: BundleTool.getBundle())
        tab.register(nib, forCellReuseIdentifier: "MineResumeAddUITableViewCell")
        
        let EduTongzhaoTableViewCell = UINib(nibName: "EduTongzhaoTableViewCell", bundle: BundleTool.getBundle())
        tab.register(EduTongzhaoTableViewCell, forCellReuseIdentifier: "EduTongzhaoTableViewCell")
        
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


extension EduExpreViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == titles!.count-1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EduTongzhaoTableViewCell") as! EduTongzhaoTableViewCell
            cell.setData(str: isTZ)
            cell.tzblock = {
              (str:String?)->() in
                self.isTZ = str
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
            cell.textfiled.text = schoolName
            cell.textChangeBlock = {
                (str:String?)->() in
                self.schoolName = str
            }
        }
        if indexPath.row==1 {
            cell.textfiled.text = xueliModel?.name
        }
        if indexPath.row==2 {
            cell.textfiled.text = xueweiModel?.name
        }
        
        if indexPath.row==3 {
            cell.textfiled.rightView = nil
            cell.textfiled.isUserInteractionEnabled = true
            cell.textfiled.text = zhuanye
            cell.textChangeBlock = {
                (str:String?)->() in
                self.zhuanye = str
            }
        }
        if indexPath.row==4 {
            cell.textfiled.text = readtime
        }
        if indexPath.row==5 {
            cell.textfiled.text = biyetime
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==4 {
            let pickView = TQDatePickerView(type: .KDatePickerDate)
            pickView.sucessReturnB = { (date: String) in
                self.readtime = date
                self.tab.reloadData()
            }
            pickView.show()
        }
        if indexPath.row==5 {
            let pickView = TQDatePickerView(type: .KDatePickerDate)
            pickView.sucessReturnB = { (date: String) in
                self.biyetime = date
                self.tab.reloadData()
            }
            pickView.show()
        }
        if indexPath.row==1 {
            getxueli()
        }
        if indexPath.row==2 {
            getxuewei()
        }
    }
    
}

extension EduExpreViewController{
    
    @objc func save() {
        
        if schoolName?.isEmpty ?? true {
            showToast(info: "请输入学校名称")
            return;
        }
        
        if zhuanye?.isEmpty ?? true {
            showToast(info: "请输入所学专业")
            return;
        }
        
        if readtime?.isEmpty ?? true {
            showToast(info: "请选择就读时间")
            return;
        }
        
        if biyetime?.isEmpty ?? true {
            showToast(info: "请选择毕业时间")
            return;
        }
        
        if xueliModel?.name?.isEmpty ?? true {
            showToast(info: "请选择学历")
            return;
        }
        
        if xueweiModel?.name?.isEmpty ?? true {
            showToast(info: "请选择学位")
            return;
        }
        
        
        var parm = ["schoolName":schoolName ?? "","major":zhuanye ?? "","studyTime": readtime ?? "","graduateTime": biyetime ?? "","unifiedEnroll":isTZ ?? "","educationId":xueliModel?.id ?? 0,"degreeId":xueweiModel?.id ?? 0] as [String : Any]
        var request:JobWantReqAPI = .addEducationExperience(parm)
        if eduModel != nil {
            parm["id"] = eduModel?.id
            request = .updateEducationExperience(parm)
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
    
    func getxueli() {
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .eduxueli)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.xueliModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    func getxuewei() {
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .eduxuewei)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.xueweiModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    
}

