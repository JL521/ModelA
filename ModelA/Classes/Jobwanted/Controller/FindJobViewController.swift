//
//  FindJobViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/17.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift

class FindJobViewController: JobWantBaseViewController {

    var tab:UITableView!
    var dataArr:[MineJobModel]?
    var dispoase = DisposeBag()
    var seletAreaView:BusiFindPeopleHeadView!
    var proIndex : Int?
    var isresume:Bool?
    
    var proModel: RegionModel?
    var cityModel:RegionModel?
    var searStr:String?
        
    var page : Int?
    
    var loaction : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我要求职"
        
        loaction = "山东省"
//        MinLocationManager.shared.startPositioning(self)
//        MinLocationManager.shared.provice = {
//            (str:String?) in
//            print(str ?? "")
//            self.loaction = str
//        }
        
        let areav = BundleTool.getBundle().loadNibNamed("BusiFindPeopleHeadView", owner: self, options: nil)?.first as! BusiFindPeopleHeadView
        areav.frame = CGRect(x: 16, y: 10, width: self.view.frame.size.width-32, height: 94)
        self.view.addSubview(areav)
        seletAreaView = areav
        areav.regionBlock = {
            (type : Int) in
            self.selectRegion(type: type)
        }
        areav.searchBlock = {
            (str : String?) in
            self.searStr = str
            self.getResumeList()
        }
        proIndex = 0
        page = 1
        
        setTabviewUI()
        isresume = true
        checkMyResume()
        getResumeList()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        page = 1
    }
    
}

extension FindJobViewController{
    
    func setTabviewUI() {
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        tab = UITableView(frame: CGRect(x: 16, y: seletAreaView.frame.maxY, width: self.view.frame.size.width-32, height: self.view.frame.size.height-statusHeight-44-(self.navigationController?.navigationBar.frame.size.height ?? 0)), style: .plain)
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
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        tab.getSource(page: 1)
               tab.refreshable(headerRefreshCallBack: {
                   [weak self] in
                   self?.tab.resetNoMoreData()
                   self?.tab.getSource(page: 1)
                   self?.page = 1
                   self?.getResumeList()
               }) {
                   [weak self] in
                   self?.page = (self?.page ?? 1) + 1
                   self?.getResumeList()
               }
        
    }
    
}


extension FindJobViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobResumeTableViewCell") as! JobResumeTableViewCell
        cell.setDataWithModel(mode: dataArr?[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView()
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
        hv.backgroundColor = .clear
        return hv
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = JobDetailViewController()
        let model = dataArr?[indexPath.section]
        vc.model = model
        vc.isResume = isresume
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FindJobViewController {
    
    func getResumeList() {
        
        let parm = ["position":searStr ?? "","companyName":"","city":proModel?.title ?? "","county": cityModel?.title ?? "","pageNum":page ?? 1,"pageSize":10] as [String:Any]
        
        JobRequestAPIProvider.rx.request(.getPostList(parm)).mapObject(BaseArrayModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

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
    
    func checkMyResume() {
                
        JobRequestAPIProvider.rx.request(.checkResumeExist).mapObject(BaseModel<MineJobModel>.self).subscribe(onSuccess: { (value) in

            if value.code == "0"{
                self.isresume = true
            }else{
                self.isresume = false
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
        
    }
    
    func selectRegion(type:Int) {
        
        let svc = MineSelectRegionControllerViewController(nibName: "MineSelectRegionControllerViewController", bundle: BundleTool.getBundle())
        svc.modalPresentationStyle = .custom
        svc.component = 1
        svc.province = loaction
        if type == 0 {
            svc.type = ReginType.city
        }else{
            svc.type = ReginType.qu
        }
        svc.cityIndexBlock = {
                (index:Int?) in
                self.proIndex = index
        }
        svc.selectCityIndex = proIndex
        
        svc.doneBlcok = {
            (proModel:RegionModel?,cityModel:RegionModel?,quModel:RegionModel?) in
            self.seletAreaView.cityl.text = quModel?.title
            self.seletAreaView.prol.text = cityModel?.title
            self.proModel = cityModel
            self.cityModel = quModel
            self.page = 1
            self.getResumeList()
        }
        self.present(svc, animated: false, completion: nil)
        
    }
    
}
