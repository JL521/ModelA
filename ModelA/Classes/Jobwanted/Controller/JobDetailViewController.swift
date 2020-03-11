//
//  JobDetailViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/10.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

class JobDetailViewController: JobWantBaseViewController {

    var tab:UITableView!
    var model:MineJobModel?
    var dispoase = DisposeBag()
    var detailModel:MineJobModel?
    var onebtn:UIButton?
    var isResume:Bool?
    var source:String?
    var bottomview:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "职位详情"
        getJobdetail()
        setTabviewUI()
        self.view.addSubview(setFooterView())
    
    }

}

extension JobDetailViewController{
    
    func setTabviewUI() {

        tab = UITableView(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width-32, height: self.view.frame.size.height-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let JobResumeTableViewCell = UINib(nibName: "JobResumeTableViewCell", bundle: BundleTool.getBundle())
        tab.register(JobResumeTableViewCell, forCellReuseIdentifier: "JobResumeTableViewCell")
        
        let JobCompanyTableViewCell = UINib(nibName: "JobCompanyTableViewCell", bundle: BundleTool.getBundle())
        tab.register(JobCompanyTableViewCell, forCellReuseIdentifier: "JobCompanyTableViewCell")
        
        let JobDetaiTableViewCell = UINib(nibName: "JobDetaiTableViewCell", bundle: BundleTool.getBundle())
        tab.register(JobDetaiTableViewCell, forCellReuseIdentifier: "JobDetaiTableViewCell")
        
        tab.estimatedRowHeight=40
        tab.tableFooterView = UIView()
        tab.separatorStyle = .none
        tab.backgroundColor = .clear
        tab.showsVerticalScrollIndicator = false
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
    }
    
}


extension JobDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==2 {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section==0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "JobResumeTableViewCell") as! JobResumeTableViewCell
            cell.setDetailDataWithModel(mode: detailModel)
           return cell
            
        }
        
        if indexPath.section==2 {
            if indexPath.row==0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCompanyTableViewCell") as! JobCompanyTableViewCell
                cell.setJobDetailDataWithModel(mode: detailModel)
                return cell
            }
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetaiTableViewCell") as! JobDetaiTableViewCell
        
        if indexPath.section==1 {
        
            cell.titll.text = "岗位简介"
            cell.desl.text = detailModel?.jobDescription
        }
        
        if indexPath.section==2 {
            if indexPath.row==1 {
                cell.titll.text = "公司地址"
                cell.desl.text = "\(detailModel?.orgProvince ?? "")\(detailModel?.orgCity ?? "")\(detailModel?.orgDistrict ?? "")"
            }
            if indexPath.row==2 {
                cell.titll.text = "公司简介"
                cell.desl.text = detailModel?.orgIntro
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView()
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
        hv.backgroundColor = .clear
        return hv
    }
    
    func setFooterView() -> UIView {
        let fv = UIView()
        fv.frame = CGRect(x: 0, y: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height, width: self.view.frame.size.width, height: 74)
        fv.backgroundColor = .white
        
        let onebtn = UIButton()
        onebtn.setTitleColor(.white, for: .normal)
        onebtn.backgroundColor = UIColor.lightGray//UIColor.init(hex: 0x828795)
        onebtn.layer.cornerRadius = 8
        onebtn.layer.masksToBounds = true
        onebtn.frame = CGRect(x: 16, y: 14, width: self.view.frame.size.width-32, height: 74-14*2)
        onebtn.tag = 2
        fv.addSubview(onebtn)
        onebtn.addTarget(self, action: #selector(offerSure(btn:)), for: .touchUpInside)
        self.onebtn = onebtn
        bottomview = fv
        return fv
    }
    
    func faburesume() {
       let vc = MineResumeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func offerSure(btn:UIButton) {
        
        if let isres = isResume {
            if isres == false {
                Alert.shared.showAlert(title: "提示", content: "您还没有自己的简历需要完善后申请", containBtnTitle: "确定") {
                    [weak self] in
                    self?.faburesume()
                }
                return
            }
            
        }
        
        let parm = ["id":detailModel?.id ?? "","companyId":detailModel?.companyId ?? 0] as [String:Any]
        JobRequestAPIProvider.rx.request(.applyPost(parm)).mapObject(BaseModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            
            if value.code == "0" {
                
                self.getJobdetail()
                
            }else{
                
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
}

extension JobDetailViewController{
    func getJobdetail() {
        
        let parm = ["id":model?.id ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.getPostDetail(parm)).mapObject(BaseModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            let resuModel = value.result
            self.detailModel = resuModel
            self.tab.reloadData()
            if (resuModel?.delivered ?? false) == false {
                
                self.onebtn?.isEnabled = true
                self.onebtn?.setTitleColor(.white, for: .normal)
                self.onebtn?.backgroundColor = UIColor.init(hex: 0x2F6AFF)
                self.onebtn?.setTitle("申请职位", for: .normal)
                
            }else{
                self.onebtn?.isEnabled = false
                self.onebtn?.setTitleColor(.white, for: .normal)
                self.onebtn?.backgroundColor = UIColor.lightGray
                self.onebtn?.setTitle("已投递", for: .normal)
            }
            if let sour = self.source{
                if sour == "min" {
                    self.bottomview?.isHidden = true
                    self.onebtn?.isHidden = true
                }
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
}
