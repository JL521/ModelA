//
//  BusiPublishJobViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class BusiPublishJobViewController: JobWantBaseViewController {

    var titles:[[String]]?
    var tab:UITableView!
    var dispoase = DisposeBag()
    
    var model : MineJobModel?
        
    var jobname:String?
    var address:String?
    var province:String?
    var city:String?
    var country:String?
    
    var xinziModel:MinePickModel?
    var xueliModel:MinePickModel?
    var workexpModel:MinePickModel?
    var num:String?
    var desc:String?
    
//    let pickerview = AddressPickerView.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: 200)) //地址
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "发布职位"
        titles = [["职位名称","职位薪资"],["学历要求","工作经验"],["工作地点","招聘人数"],["岗位简介"]]
        
        if (model != nil) {
            title = "编辑职位"
            jobname = model?.jobName ?? ""
            address = model?.site ?? ""
            province = model?.province ?? ""
            city = model?.city ?? ""
            country = model?.qu ?? ""
            num = "\(model?.jobNumber ?? 0)"
            desc = model?.jobDescription ?? ""
            
            xueliModel = MinePickModel()
            xueliModel?.name = model?.education ?? ""
            
            xinziModel = MinePickModel()
            xinziModel?.name = model?.salary ?? ""
            
            workexpModel = MinePickModel()
            workexpModel?.name = model?.workyears ?? ""
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "yulanres"), style: .plain, target: self, action: #selector(loockJob))
        }
        
        setTabviewUI()
        
    }
    
    @objc func loockJob() {
            
        model?.jobName = jobname
        model?.site = address
        
        model?.province = province
        model?.city = city
        model?.qu = country
        
        let numstr = NSString(string: num ?? "0")
           model?.jobNumber = numstr.integerValue
            model?.jobDescription = desc
                
            model?.education = xueliModel?.name
            model?.salary = xinziModel?.name
            model?.workyears = workexpModel?.name
               
        let vc = BusiJobDetailViewController()
        vc.model = model
        vc.type = "1"
        self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
}
    
  


extension BusiPublishJobViewController{
    
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
        btn.setTitle("确定发布", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
        btn.frame = CGRect(x: 16, y: 14, width: fv.frame.size.width-32, height: 74-14*2)
        fv.addSubview(btn)
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)
        if (model != nil) {
            btn.setTitle("保存", for: .normal)
        }
        
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


extension BusiPublishJobViewController:UITableViewDelegate,UITableViewDataSource{
    
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
            cell.namel.text = "岗位简介"
            cell.setCount(count: 2000)
            cell.setText(str: desc)
            cell.descl.text = "请输入岗位简介"
            cell.textChangeBlock = {
                (str : String?)->() in
                self.desc = str
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
            
            if indexPath.row == 0 {
                cell.textfiled.isUserInteractionEnabled = true
                cell.textfiled.rightView = nil
                cell.textfiled.text = jobname
                cell.textChangeBlock = {
                    (str:String?)->() in
                    self.jobname = str
                }
            }
            if indexPath.row == 1 {
                cell.textfiled.text = xinziModel?.name
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row==0 {
                cell.textfiled.text = xueliModel?.name
            }
            if indexPath.row==1 {
                cell.textfiled.text = workexpModel?.name
            }
            
        }
        
        if indexPath.section == 2 {
            if indexPath.row==0 {
                cell.textfiled.text = address
            }
            if indexPath.row==1 {
                cell.textfiled.rightView = nil
                cell.textfiled.isUserInteractionEnabled = true
                cell.textfiled.text = num
                cell.textChangeBlock = {
                    (str:String?)->() in
                    self.num = str
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section==0 && indexPath.row==1 {
            getYuexin()
        }
        if indexPath.section==1 && indexPath.row==0 {
            getxueli()
        }
        if indexPath.section==1 && indexPath.row==1 {
            getexperience()
        }
        if indexPath.section==2 && indexPath.row == 0 {
            getLocation()
        }
    }
    
}

extension BusiPublishJobViewController{
    
    
    @objc func save() {
        
        if jobname?.isEmpty ?? true {
            showToast(info: "请输入职位名称")
            return;
        }
        
        if xinziModel?.name?.isEmpty ?? true {
            showToast(info: "请选择职位薪资")
            return;
        }
        
        if xueliModel?.name?.isEmpty ?? true {
            showToast(info: "请选择学历要求")
            return;
        }
        
        if workexpModel?.name?.isEmpty ?? true {
            showToast(info: "请选择工作经验")
            return;
        }
        
        if address?.isEmpty ?? true {
            showToast(info: "请选择工作地点")
            return;
        }
        
        if num?.isEmpty ?? true {
            showToast(info: "请输入招聘人数")
            return;
        }
        
        
        var parm = ["jobName" : jobname ?? "","salary": xinziModel?.name ?? "","education":xueliModel?.name ?? "","workyears":workexpModel?.name ?? "","site":address ?? "","jobNumber":num ?? "" , "jobDescription": desc ?? "" ] as [String : Any]
        parm["province"] =  province ?? ""
        parm["city"] =  city ?? ""
        parm["county"] =  country ?? ""
        var request:JobWantReqAPI = .addmanagejob(parm)
        
        if (model != nil){
            parm["id"] = model?.id ?? 0
            request = .updateJob(parm)
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
                    if cd == "0" {
                    let vc = BusiPublishSuccessViewController(nibName: "BusiPublishSuccessViewController", bundle: BundleTool.getBundle())
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }
                   
               }) { (error) in
                DispatchQueue.main.async {
                    Activity.shared.dismiss()
                }
                   
               }.disposed(by: dispoase)
        
    }
    
    func getYuexin() {
        
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .yuexin)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.xinziModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
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
    
    func getexperience() {
        let vc = MIneChoseRegionViewController(nibName: "MIneChoseRegionViewController", bundle: BundleTool.getBundle())
        vc.modalPresentationStyle = .custom
        vc.getDataSource(type: .experience)
        vc.doneBlcok = {
            (model:MinePickModel)->() in
            self.workexpModel = model
            self.tab.reloadData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    func getLocation() {
        let svc = MineSelectRegionControllerViewController(nibName: "MineSelectRegionControllerViewController", bundle: BundleTool.getBundle())
        svc.modalPresentationStyle = .custom
        svc.doneBlcok = {
            (proModel:RegionModel?,cityModel:RegionModel?,quModel:RegionModel?) in
            self.address = "\(proModel?.title ?? "") \(cityModel?.title ?? "") \(quModel?.title ?? "")"
            self.province = proModel?.title ?? ""
            self.city = cityModel?.title ?? ""
            self.country = quModel?.title ?? ""
            self.tab.reloadData()
        }
        self.present(svc, animated: false, completion: nil)
    }
    
}

