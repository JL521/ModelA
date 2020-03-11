//
//  BusiJobDetailViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

class BusiJobDetailViewController: JobWantBaseViewController {

    var tab:UITableView!
    var model:MineJobModel?
    var dispoase = DisposeBag()
    var detailModel:MineJobModel?
    
    var type:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "职位详情"
        
        if type == nil {
           getJobdetail()
        }else{
            detailModel = model
        }
        setTabviewUI()
    }

}

extension BusiJobDetailViewController{
    
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
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 88, right: 0)
        
    }
    
}


extension BusiJobDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section==0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "JobResumeTableViewCell") as! JobResumeTableViewCell
            cell.setBusiDataWithModel(mode: detailModel)
            cell.busjobeditbtn.isHidden = false
            cell.tapBlock = {
                self.editJob()
            }
            if let show = type{
                if show == "1" {
                    cell.busjobeditbtn.isHidden = true
                }
            }
           return cell
            
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetaiTableViewCell") as! JobDetaiTableViewCell
        
        if indexPath.section==1 {
        
            cell.titll.text = "岗位简介"
            cell.desl.text = detailModel?.jobDescription
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
    
    
}

extension BusiJobDetailViewController{
    func getJobdetail() {
        
        let parm = ["id":model?.id ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.getbyId(parm)).mapObject(BaseArrayModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            let resuModelarr = value.result
            if resuModelarr != nil && resuModelarr?.count ?? 0 > 0{
                self.detailModel = resuModelarr?[0]
            }
            self.tab.reloadData()
            

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
    func editJob() {
        let vc = BusiPublishJobViewController()
        vc.model = detailModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

