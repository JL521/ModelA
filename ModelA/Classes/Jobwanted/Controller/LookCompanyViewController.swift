//
//  LookCompanyViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/16.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

class LookCompanyViewController: JobWantBaseViewController {

    var tab:UITableView!
    var companyId:String?
    var dispoase = DisposeBag()
    var detailModel:MineCompanyModel?
    var dataArr : [MineJobModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "公司信息"
        getCompanyInfo()
        getCompanyzhiweilist()
        setTabviewUI()
        
    
    }

}

extension LookCompanyViewController{
    
    func setTabviewUI() {

        dataArr = []
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
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
    }
    
}


extension LookCompanyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (dataArr?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row==0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "JobCompanyTableViewCell") as! JobCompanyTableViewCell
                    cell.setCompanyDataWithModel(mode: detailModel)
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetaiTableViewCell") as! JobDetaiTableViewCell
                if indexPath.row==1 {
                    cell.titll.text = "公司地址"
                    cell.desl.text = detailModel?.province
                }
                if indexPath.row==2 {
                    cell.titll.text = "公司简介"
                    cell.desl.text = detailModel?.intro
                }
                        
            return cell
        }
            
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobResumeTableViewCell") as! JobResumeTableViewCell
        cell.setDataWithModel(mode: dataArr?[indexPath.section-1])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==1 {
            return 30
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView()
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30)
        hv.backgroundColor = .clear
        
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: hv.frame.size.width, height: 30))
        lable.textColor = UIColor.init(hex: 0xAEB5C5)
        lable.font = UIFont.systemFont(ofSize: 14)
        hv.addSubview(lable)
        
        if section==1 {
            lable.text = "发布的职位"
        }else{
            lable.text = nil
        }
        
        return hv
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let vc = JobDetailViewController()
            vc.model = dataArr?[indexPath.section-1]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension LookCompanyViewController{
    func getCompanyInfo() {
        
        let parm = ["companyId":companyId ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.getCompanyInfo(parm)).mapObject(BaseModel<MineCompanyModel>.self).subscribe(onSuccess: { (value) in

            let resuModel = value.result
            self.detailModel = resuModel
            self.tab.reloadData()

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
    func getCompanyzhiweilist() {
        
        let parm = ["companyId":companyId ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.getCompanyPostList(parm)).mapObject(BaseArrayModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            let resuModelArr = value.result
            self.dataArr = resuModelArr
            self.tab.reloadData()

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
}


