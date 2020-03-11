//
//  BusiInvationsViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

class BusiInvationsViewController: JobWantBaseViewController {

    var tab:UITableView!
    var applyId:String?
    var dispoase = DisposeBag()
    var detailModel:MineOfferModel?
    var footV:UIView?
    var canbtn:UIButton?
    var surebtn:UIButton?
    var onebtn:UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "面试通知"
        setTabviewUI()
    
        getOfferdetail()
    }

}

extension BusiInvationsViewController{
    
    func setTabviewUI() {

        tab = UITableView(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width-32, height: self.view.frame.size.height-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
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


extension BusiInvationsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==3 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetaiTableViewCell") as! JobDetaiTableViewCell
        
        cell.titll.textColor = UIColor.init(hex: 0x494D58)
        cell.desl.textColor = UIColor.init(hex: 0x494D58)
        
        cell.companyBtn.isHidden = true
        
        if indexPath.section==0 {
        
            if indexPath.row==0 {
                cell.titll.text = "面试公司"
                cell.desl.text = detailModel?.companyName
            }
            if indexPath.row==1 {
                cell.titll.text = "面试职位"
                cell.desl.text = detailModel?.jobName
            }
            
        }
        
        if indexPath.section==1 {
        
            if indexPath.row==0 {
                cell.titll.text = "面试地点"
                cell.desl.text = detailModel?.workyears
            }
            if indexPath.row==1 {
                cell.titll.text = "面试时间"
                cell.desl.text = detailModel?.interviewTime
            }
        }
        
        if indexPath.section==2 {
            if indexPath.row==0 {
                cell.titll.text = "联系人"
                cell.desl.text = detailModel?.contate
            }
            if indexPath.row==1 {
                cell.titll.text = "联系方式"
                cell.desl.text = detailModel?.phone
            }
        }
        
        if indexPath.section==3 {
            
            cell.titll.text = "注意事项"
            cell.desl.text = detailModel?.attention
            
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hv = UIView()
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20)
        hv.backgroundColor = .clear
        return hv
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section==3 {
            return 20
        }
        return 0
    }
    
}

extension BusiInvationsViewController{
    func getOfferdetail() {
        
        let parm = ["id":applyId ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.allinit(parm)).mapObject(BaseModel<MineOfferModel>.self).subscribe(onSuccess: { (value) in

            let resuModel = value.result
            self.detailModel = resuModel
            self.tab.reloadData()

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
    
}

