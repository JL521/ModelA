//
//  RecivedResumeListViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/17.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift

class RecivedResumeListViewController: JobWantBaseViewController {

    var tab:UITableView!
    var status:String?
    var dataArr:[BussRecivedResumeModel]?
    var dispoase = DisposeBag()
    var page : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        page = 1
        setTabviewUI()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        page = 1
        getResumeList(status: status)
    }
    
}

extension RecivedResumeListViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width-32, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let nib = UINib(nibName: "BusiReciveResumeCell", bundle: BundleTool.getBundle())
        tab.register(nib, forCellReuseIdentifier: "BusiReciveResumeCell")
        tab.estimatedRowHeight=40
        tab.tableFooterView = UIView()
        tab.separatorStyle = .none
        tab.backgroundColor = .clear
        tab.showsVerticalScrollIndicator = false
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        tab.getSource(page: 1)
        tab.refreshable(headerRefreshCallBack: {
            [weak self] in
            self?.tab.resetNoMoreData()
            self?.tab.getSource(page: 1)
            self?.page = 1
            self?.getResumeList(status: self?.status)
        }) {
            [weak self] in
            self?.page = (self?.page ?? 1) + 1
            self?.getResumeList(status: self?.status)
        }
        
    }
    
}


extension RecivedResumeListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusiReciveResumeCell") as! BusiReciveResumeCell
        cell.setBusiRecivedResumeDataWithModel(mode: dataArr?[indexPath.section])
        cell.moneyl.textColor = UIColor.init(hex: 0x21C3B1)
        if (status == "1") || (status == "2"){
            cell.moneyl.text = "查看通知>"
            cell.moneyl.textColor = UIColor.init(hex: 0x2F6AFF)
            cell.tapBlock = {
                let model = self.dataArr?[indexPath.section]
                self.cktz(applyId: "\(model?.jobUserId ?? 0)")
            }
        }
        if status == "3"{
            cell.moneyl.text = "已结束"
            cell.moneyl.textColor = UIColor.init(hex: 0x828896)
            cell.sjview.backgroundColor = UIColor.init(hex: 0xE4E8F2)
            cell.sjl.textColor = UIColor.init(hex: 0xAEB5C5)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BusiLookResumeViewController()
        let model = dataArr?[indexPath.section]
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RecivedResumeListViewController {
    
    func getResumeList(status:String?) {
        
        let parm = ["state":status ?? "","pageNum":page ?? 1,"pageSize":10] as [String:Any]
        JobRequestAPIProvider.rx.request(.getVuate(parm)).mapObject(BaseArrayModel<BussRecivedResumeModel>.self).subscribe(onSuccess: { (value) in

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
    
    func cktz(applyId:String?) {
      let vc = BusiInvationsViewController()
        vc.applyId = applyId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
