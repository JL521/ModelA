//
//  BusiLookResumeViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

class BusiLookResumeViewController: JobWantBaseViewController {

    var tab:UITableView!
    var infoView:MineResumeInfoView!
    var titles:[String]?
    var dispoase = DisposeBag()
    var resumeModel:BusiResumeDetaiModel?
    var model:BussRecivedResumeModel?
    var findPeoplemodel:BussFindPeopleModel?
    var footv:UIView?
    var footbtn:UIButton?
    var type:String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "简历详情"
        titles = ["求职意向","工作经验","项目经验","教育经历","附加简历"]
        setTableview()
        view.addSubview(setFooterView())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBarBackground(titlecolor: UIColor.white, itemcolor: UIColor.white, barcolor: UIColor.init(hex: 0x2F6AFF, alpha: 1))
        getResume()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        setNavBarBackground(titlecolor: UIColor.init(hex: 0x494D58, alpha: 1), itemcolor: UIColor.init(hex: 0x494D58, alpha: 1), barcolor: UIColor.white)
    }
    
    
}

extension BusiLookResumeViewController{
    
    func setTableview() {
        
        tab = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height), style: .grouped)
        self.view.addSubview(tab)
        tab.delegate = self
        tab.dataSource = self
        
        let JobResumeTableViewCell = UINib(nibName: "JobResumeTableViewCell", bundle: BundleTool.getBundle())
        tab.register(JobResumeTableViewCell, forCellReuseIdentifier: "JobResumeTableViewCell")
        
        let MineResumeNoInfoTableViewCell = UINib(nibName: "MineResumeNoInfoTableViewCell", bundle: BundleTool.getBundle())
        tab.register(MineResumeNoInfoTableViewCell, forCellReuseIdentifier: "MineResumeNoInfoTableViewCell")
        
        let MineJobExpectTableViewCell = UINib(nibName: "MineJobExpectTableViewCell", bundle: BundleTool.getBundle())
        tab.register(MineJobExpectTableViewCell, forCellReuseIdentifier: "MineJobExpectTableViewCell")
        
        let MineJobWorkjlTableViewCell = UINib(nibName: "MineJobWorkjlTableViewCell", bundle: BundleTool.getBundle())
        tab.register(MineJobWorkjlTableViewCell, forCellReuseIdentifier: "MineJobWorkjlTableViewCell")
        
        let ResumeFJTableViewCell = UINib(nibName: "ResumeFJTableViewCell", bundle: BundleTool.getBundle())
        tab.register(ResumeFJTableViewCell, forCellReuseIdentifier: "ResumeFJTableViewCell")
        
        tab.estimatedRowHeight=1
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
        infoView = BundleTool.getBundle().loadNibNamed("MineResumeInfoView", owner: self, options: nil)?.first as? MineResumeInfoView
        infoView.frame = CGRect(x: 0, y: 0, width: tab.frame.size.width, height: 210)
        tab.tableHeaderView = infoView
        tab.separatorStyle = .none
    }
    
}


extension BusiLookResumeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return  titles!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==1 {
            return resumeModel?.resume?.workExperienceList?.count ?? 0
        }
        if section==2 {
            return resumeModel?.resume?.projectExperienceList?.count ?? 0
        }
        if section==3 {
            return resumeModel?.resume?.educationExperienceList?.count ?? 0
        }
        if section==5 {
            return  0
        }
        if section==4 {
            if resumeModel?.resume?.attachment != nil && resumeModel?.resume?.attachment != ""{
                return 1
            }
        }
        
        if section==0 {
            if resumeModel?.resume?.industryId == nil || resumeModel?.resume?.industryName == nil || resumeModel?.resume?.positionId == nil || resumeModel?.resume?.positionName == nil {
                return 0
            }else{
                return 1
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobExpectTableViewCell") as! MineJobExpectTableViewCell
            cell.setDataWithModel(mode: resumeModel?.resume)
            return cell
        }
        if indexPath.section==1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobWorkjlTableViewCell") as! MineJobWorkjlTableViewCell
            let model = resumeModel?.resume?.workExperienceList?[indexPath.row]
            cell.setDataWithWorkModel(mode: model)
            cell.rightimgv.isHidden = true
            cell.desl.numberOfLines = 0
            return cell
        }
        if indexPath.section==2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobWorkjlTableViewCell") as! MineJobWorkjlTableViewCell
            let model = resumeModel?.resume?.projectExperienceList?[indexPath.row]
            cell.setDataWithProjectModel(mode: model)
            cell.rightimgv.isHidden = true
            cell.desl.numberOfLines = 0
            return cell
        }
        
        if indexPath.section==3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobWorkjlTableViewCell") as! MineJobWorkjlTableViewCell
            let model = resumeModel?.resume?.educationExperienceList?[indexPath.row]
            cell.setDataWithEduModel(mode: model)
            cell.rightimgv.isHidden = true
            cell.desl.numberOfLines = 0
            return cell
        }
        
        if indexPath.section==4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResumeFJTableViewCell") as! ResumeFJTableViewCell
            cell.selectblock = {
                (index:String) in
                self.lookResume(str: index)
            }
            cell.type = 1
            if resumeModel?.resume?.attachment != nil && resumeModel?.resume?.attachment != ""{
                let attchArr = resumeModel?.resume?.attachment?.components(separatedBy: ",")
                cell.setData(arr: attchArr)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineResumeNoInfoTableViewCell") as! MineResumeNoInfoTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5{
            return 20
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        let hv = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
        hv.backgroundColor = UIColor.clear
        hv.text = nil
        hv.textColor = UIColor.init(hex: 0x828896)
        hv.font = UIFont.systemFont(ofSize: 12)
        hv.frame = CGRect.zero
        if section == 5{
            hv.text = "隐藏后除了已申请的职位外，将不会有其他公司看到您的简历"
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20)
            hv.frame = CGRect(x: 16, y: 0, width: view.frame.size.width-32, height: 20)
            view.addSubview(hv)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = Bundle.main.loadNibNamed("MineResumeHeadView", owner: self, options: nil)?.first as! MineResumeHeadView
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
        let str = titles![section]
        hv.titlel.text = str
        hv.detaill.text = nil
        hv.btn.tag = section
        hv.btn.isHidden = true
        hv.switchBtn.isHidden = true
        return hv
    }
    
    func setFooterView() -> UIView {
           let fv = UIView()
           fv.frame = CGRect(x: 0, y: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height, width: tab.frame.size.width, height: 74)
           fv.backgroundColor = .white
           
           let surebtn = UIButton()
           surebtn.setTitle("邀请面试", for: .normal)
           surebtn.setTitleColor(.white, for: .normal)
           surebtn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
           surebtn.layer.cornerRadius = 8
           surebtn.layer.masksToBounds = true
           surebtn.frame = CGRect(x: 16, y: 14, width: tab.frame.size.width-32, height: 74-14*2)
           surebtn.tag = 2
           surebtn.addTarget(self, action: #selector(offerSure(btn:)), for: .touchUpInside)
           fv.addSubview(surebtn)
           footbtn = surebtn;
           footv = fv
        
           return fv
       }
    
}

extension BusiLookResumeViewController {
 

    
    func getResume() {
               
        var parm = ["onlyId" : 0] as [String:Any]
        
        if let mo = model {
            parm = ["onlyId" : mo.id ?? 0]
        }else if let mod = findPeoplemodel {
            parm = ["onlyId" : mod.id ?? 0]
        }
        
        var request : JobWantReqAPI = .getCurriculumVitae(parm)
        if type == "1" {
            request = .getCurriculumUser(parm)
        }
        JobRequestAPIProvider.rx.request(request).mapObject(BaseModel<BusiResumeDetaiModel>.self).subscribe(onSuccess: { (value) in

            let resuModel = value.result
            self.resumeModel = resuModel
            self.infoView.setDataWithModel(mode: self.resumeModel?.resume)
            
            self.tab.reloadData()
            if resuModel?.accept_state == 0{
                self.footv?.isHidden = false
            }else{
                self.footv?.isHidden = true
                if self.type == "1"{
                    self.footv?.isHidden = false
                }
                self.footbtn?.isEnabled = false
                self.footbtn?.setTitle("已邀请", for: .normal)
                self.footbtn?.backgroundColor = .lightGray
            }


        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
                
    }
    
    func lookResume(str:String) {
        
        
        let vc = LookResumeViewController()
        vc.url = str
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func offerSure(btn:UIButton){
        
        let vc = BusiInviteMSViewController()
        if let mo = model {
            vc.model = mo
        }else if let mod = findPeoplemodel {
            vc.findmodel = mod
        }
        vc.detailModel = resumeModel
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

