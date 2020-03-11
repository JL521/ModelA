//
//  InvitaionsViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/10.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

class InvitaionsViewController: JobWantBaseViewController {

    var tab:UITableView!
    var applyId:String?
    var dispoase = DisposeBag()
    var detailModel:MineOfferModel?
    var footV:UIView?
    var canbtn:UIButton?
    var surebtn:UIButton?
    var onebtn:UIButton?
    var source:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "面试通知"
        setTabviewUI()
    
        getOfferdetail()
    }

}

extension InvitaionsViewController{
    
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
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        self.view.addSubview(setFooterView())
        
    }
    
}


extension InvitaionsViewController:UITableViewDelegate,UITableViewDataSource{
    
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
                cell.companyBtn.isHidden = false
                cell.lookCompanyBlock = {
                    self.lookCompany()
                }
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
    
    func setFooterView() -> UIView {
        let fv = UIView()
        fv.frame = CGRect(x: 0, y: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height, width: self.view.frame.size.width, height: 74)
        fv.backgroundColor = .white
        
        let canbtn = UIButton()
        canbtn.setTitle("忽略", for: .normal)
        canbtn.setTitleColor(UIColor.init(hex: 0x2F6AFF), for: .normal)
        canbtn.backgroundColor = .white
        canbtn.layer.borderColor = UIColor.init(hex: 0x2F6AFF).cgColor
        canbtn.layer.borderWidth = 1
        canbtn.layer.cornerRadius = 8
        canbtn.layer.masksToBounds = true
        canbtn.frame = CGRect(x: 16, y: 14, width: 0.5*(self.view.frame.size.width-48), height: 74-14*2)
        canbtn.tag = 3
        canbtn.addTarget(self, action: #selector(offerSure(btn:)), for: .touchUpInside)
        fv.addSubview(canbtn)
        self.canbtn = canbtn
        
        let surebtn = UIButton()
        surebtn.setTitle("接受邀请", for: .normal)
        surebtn.setTitleColor(.white, for: .normal)
        surebtn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
        surebtn.layer.cornerRadius = 8
        surebtn.layer.masksToBounds = true
        surebtn.frame = CGRect(x: canbtn.frame.maxX+16, y: 14, width: 0.5*(self.view.frame.size.width-48), height: 74-14*2)
        surebtn.tag = 2
        surebtn.addTarget(self, action: #selector(offerSure(btn:)), for: .touchUpInside)
        fv.addSubview(surebtn)
        footV = fv
        self.surebtn = surebtn
        
        let onebtn = UIButton()
        onebtn.setTitleColor(.white, for: .normal)
        onebtn.backgroundColor = UIColor.lightGray//UIColor.init(hex: 0x828795)
        onebtn.layer.cornerRadius = 8
        onebtn.layer.masksToBounds = true
        onebtn.frame = CGRect(x: 16, y: 14, width: self.view.frame.size.width-32, height: 74-14*2)
        onebtn.tag = 2
        fv.addSubview(onebtn)
        self.onebtn = onebtn
        
        return fv
    }
    
    func setBootmView(status:Int) {
        canbtn?.isHidden = true
        surebtn?.isHidden = true
        onebtn?.isHidden = true
        if status == 1 {
            canbtn?.isHidden = false
            surebtn?.isHidden = false
        }else if status == 0 {
            onebtn?.isHidden = false
            onebtn?.setTitle("已投递", for: .normal)
        }else if status == 2 {
           onebtn?.isHidden = false
            onebtn?.setTitle("已接受", for: .normal)
            
        }else if status == 3 {
            onebtn?.isHidden = false
            onebtn?.setTitle("已结束", for: .normal)
        }
        if let sour = self.source{
            if sour == "min" && status != 1{
                self.footV?.isHidden = true
                self.onebtn?.isHidden = true
            }
        }
    }
    
}

extension InvitaionsViewController{
    func getOfferdetail() {
        
        let parm = ["applyId":applyId ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.getInterviewInvitation(parm)).mapObject(BaseModel<MineOfferModel>.self).subscribe(onSuccess: { (value) in

            let resuModel = value.result
            self.detailModel = resuModel
            self.tab.reloadData()
            self.setBootmView(status: self.detailModel?.acceptState ?? 0)

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
    @objc func offerSure(btn:UIButton!){
        
        let parm = ["applyId":applyId ?? "","acceptStatus":btn.tag] as [String:Any]
        JobRequestAPIProvider.rx.request(.acceptInvitation(parm)).mapObject(BaseModel<MineOfferModel>.self).subscribe(onSuccess: { (value) in

            if value.code == "0"{
                self.getOfferdetail()
            }else{
                
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
    func lookCompany() {
        let vc = LookCompanyViewController()
        vc.companyId = "\(detailModel?.companyId ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

