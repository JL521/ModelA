//
//  InvitationsListViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/10.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift

class InvitationsListViewController: JobWantBaseViewController {

    var tab:UITableView!
    var status:String?
    
    var page : Int?
    
    var dataArr:[MineOfferModel]?
    var dispoase = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        page = 1
        setTabviewUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        page = 1
        getOfferList(status: status)
    }

}

extension InvitationsListViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width-32, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let InvitationsTableViewCell = UINib(nibName: "InvitationsTableViewCell", bundle: BundleTool.getBundle())
        tab.register(InvitationsTableViewCell, forCellReuseIdentifier: "InvitationsTableViewCell")
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
            self?.getOfferList(status: self?.status)
        }) {
            [weak self] in
            self?.page = (self?.page ?? 1) + 1
            self?.getOfferList(status: self?.status)
        }
        
    }
    
}


extension InvitationsListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvitationsTableViewCell") as! InvitationsTableViewCell
        cell.deleteBlcok = {
            [weak self] in
            self?.delete(index: indexPath.section)
        }
        cell.setDataWithModel(mode: dataArr?[indexPath.section])
        if self.status == "3" {
            cell.statel.isHidden = false
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
        let vc = InvitaionsViewController()
        let model = dataArr?[indexPath.section]
        vc.applyId = "\(model?.applyId ?? 0)"
        vc.source = "min"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension InvitationsListViewController{
    
    func delete(index:Int) {
        
        Alert.shared.showAlert(title: "提示", content: "确定要删除该职位吗么？", containBtnTitle: "确定") {
            [weak self] in
            self?.deleteOffer(index: index)
        }
        
    }
    
}

extension InvitationsListViewController {
    
    func getOfferList(status:String?) {
        
        let parm = ["status":status ?? "","pageNum":page ?? 1,"pageSize":"10"] as [String:Any]
        JobRequestAPIProvider.rx.request(.getInvitePostList(parm)).mapObject(BaseArrayModel<MineOfferModel>.self).subscribe(onSuccess: { (value) in

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
    
    func deleteOffer(index:Int) {
        
        let model = dataArr?[index]
        let parm = ["applyId":model?.applyId ?? ""] as [String:Any]
        JobRequestAPIProvider.rx.request(.deleteInvitation(parm)).mapObject(BaseArrayModel<MineOfferModel>.self).subscribe(onSuccess: { (value) in

            if value.code == "0"{
                self.getOfferList(status: self.status)
            }else{
                
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
}
