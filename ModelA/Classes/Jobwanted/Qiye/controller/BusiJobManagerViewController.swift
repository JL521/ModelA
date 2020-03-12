//
//  BusiJobManagerViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift

class BusiJobManagerViewController: JobWantBaseViewController {

    var tab:UITableView!
    var dataArr:[MineJobModel]?
    var dispoase = DisposeBag()
    var bgview:BusiNoJobView?
    var page : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "管理职位"
        page = 1
        setTabviewUI()
        view.addSubview(setFooterView())
    
        bgview = BundleTool.getBundle().loadNibNamed("BusiNoJobView", owner: self, options: nil)?.first as? BusiNoJobView
        bgview?.frame = view.bounds
        bgview?.block = {
            [weak self] in
            let vc = BusiPublishJobViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        view.addSubview(bgview!)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        page = 1
        getJobList()
    }
    
}

extension BusiJobManagerViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width-32, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let nib = UINib(nibName: "JobResumeTableViewCell", bundle: BundleTool.getBundle())
        tab.register(nib, forCellReuseIdentifier: "JobResumeTableViewCell")
        tab.estimatedRowHeight=40
        tab.tableFooterView = UIView()
        tab.separatorStyle = .none
        tab.backgroundColor = .clear
        tab.showsVerticalScrollIndicator = false
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
        tab.getSource(page: 1)
        tab.refreshable(headerRefreshCallBack: {
            [weak self] in
            self?.tab.resetNoMoreData()
            self?.tab.getSource(page: 1)
            self?.page = 1
            self?.getJobList()
        }) {
            [weak self] in
            self?.page = (self?.page ?? 1) + 1
            self?.getJobList()
        }
        
    }
    
}


extension BusiJobManagerViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobResumeTableViewCell") as! JobResumeTableViewCell
        cell.setDetailDataWithModel(mode: dataArr?[indexPath.section])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BusiJobDetailViewController()
        let model = dataArr?[indexPath.section]
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        
        return true
    }


    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
            return "删除"
        }
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
        {
            
            if editingStyle == UITableViewCell.EditingStyle.delete {
                
                
                Alert.shared.showAlert(title: "提示", content: "确定要删除该职位么？", containBtnTitle: "确定") {
                    self.deleteJob(model: self.dataArr?[indexPath.section])
                }
                
            }
        }
    
    func setFooterView() -> UIView {
              let fv = UIView()
              fv.frame = CGRect(x: 0, y: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height, width: self.view.frame.size.width, height: 74)
              fv.backgroundColor = .white
              
              let surebtn = UIButton()
              surebtn.setTitle("发布职位", for: .normal)
              surebtn.setTitleColor(.white, for: .normal)
              surebtn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
              surebtn.layer.cornerRadius = 8
              surebtn.layer.masksToBounds = true
              surebtn.frame = CGRect(x: 16, y: 14, width: self.view.frame.size.width-32, height: 74-14*2)
              surebtn.tag = 2
              surebtn.addTarget(self, action: #selector(offerSure(btn:)), for: .touchUpInside)
              fv.addSubview(surebtn)
           
              return fv
    }
    
}

extension BusiJobManagerViewController {
    
    func getJobList() {
        
        let parm = ["pageNum":page ?? 1,"pageSize":10] as [String:Any]
        JobRequestAPIProvider.rx.request(.getmanagejob(parm)).mapObject(BaseArrayModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            let resuModelArr = value.result
            
            if self.page == 1 {
                self.dataArr = resuModelArr
            }else{
                if let arr = resuModelArr {
                    if arr.count > 0 {
                        self.dataArr?.append(contentsOf: arr)
                    }else{
                        self.tab.endRefresh(loadNoData: true)
                    }
                }else{
                    self.tab.endRefresh(loadNoData: true)
                }
                
            }

            var isempty = true
            if let dataarr = self.dataArr {
                isempty = dataarr.count == 0
            }
             
            if isempty {
                self.bgview?.isHidden = false
            }else{
                self.bgview?.isHidden = true
            }
            
            DispatchQueue.main.async {
                self.tab.endRefresh()
                self.tab.emptyCheckWithIsNoData(isNoData:isempty)
                self.tab.reloadData()
            }

        }) { (error) in
            print(error)
            DispatchQueue.main.async {
                self.tab.endRefresh()
            }
        }.disposed(by: dispoase)
        
    }
    
    @objc func offerSure(btn:UIButton){
        
        let vc = BusiPublishJobViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func deleteJob(model:MineJobModel?) {
        let parm = ["id":model?.id ?? 0] as [String:Any]
        JobRequestAPIProvider.rx.request(.deleteJob(parm)).mapObject(BaseArrayModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            if value.code == "0"{
                self.getJobList()
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
    }
    
}
