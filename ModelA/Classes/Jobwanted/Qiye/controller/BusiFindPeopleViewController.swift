//
//  BusiFindPeopleViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift

class BusiFindPeopleViewController: JobWantBaseViewController {

    var tab:UITableView!
    var dataArr:[BussFindPeopleModel]?
    var dispoase = DisposeBag()
    var seletAreaView:BusiFindPeopleHeadView!
    var proModel: RegionModel?
    var cityModel:RegionModel?
    var searStr:String?
    
    var page : Int?
    
    var proIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我要求才"

        page = 1
        let areav = Bundle.main.loadNibNamed("BusiFindPeopleHeadView", owner: self, options: nil)?.first as! BusiFindPeopleHeadView
        areav.frame = CGRect(x: 16, y: 10, width: self.view.frame.size.width-32, height: 94)
        self.view.addSubview(areav)
        seletAreaView = areav
        areav.searchBar.placeholder = "请输入招聘职位"
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
        setTabviewUI()
        getResumeList()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        page = 1
    }
    
}

extension BusiFindPeopleViewController{
    
    func setTabviewUI() {

        tab = UITableView(frame: CGRect(x: 16, y: seletAreaView.frame.maxY, width: self.view.frame.size.width-32, height: self.view.frame.size.height-seletAreaView.frame.maxY), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        
        let BusiReciveResumeCell = UINib(nibName: "BusiReciveResumeCell", bundle: BundleTool.getBundle())
        tab.register(BusiReciveResumeCell, forCellReuseIdentifier: "BusiReciveResumeCell")
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
            self?.getResumeList()
        }) {
            [weak self] in
            self?.page = (self?.page ?? 1) + 1
            self?.getResumeList()
        }
        
        let fv = UIView()
        fv.frame = CGRect(x: 0, y: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height, width: self.view.frame.size.width, height: 74)
        fv.backgroundColor = .white
        view.addSubview(fv)
        
        let btn = UIButton()
        btn.setTitle("发布职位", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
        btn.frame = CGRect(x: 16, y: 14, width: fv.frame.size.width-32, height: 74-14*2)
        fv.addSubview(btn)
        btn.addTarget(self, action: #selector(publish), for: .touchUpInside)
        
    }
    
}


extension BusiFindPeopleViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusiReciveResumeCell") as! BusiReciveResumeCell
        cell.setBusFindPeopleDataWithModel(mode: dataArr?[indexPath.section])
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
        
        let vc = BusiLookResumeViewController()
        let model = dataArr?[indexPath.section]
        vc.findPeoplemodel = model
        vc.type = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BusiFindPeopleViewController {
    
    func getResumeList() {
        
        let parm = ["pageNum":page ?? 1,"pageSize":10,"province":proModel?.title ?? "","city":cityModel?.title ?? "","name":searStr ?? ""] as [String:Any]
        
        JobRequestAPIProvider.rx.request(.getVitaeByJobName(parm)).mapObject(BaseArrayModel<BussFindPeopleModel>.self).subscribe(onSuccess: { (value) in

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
    
    @objc func publish() {
        let vc = BusiPublishJobViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectRegion(type:Int) {
        
        let svc = MineSelectRegionControllerViewController(nibName: "MineSelectRegionControllerViewController", bundle: BundleTool.getBundle())
        svc.modalPresentationStyle = .custom
        svc.component = 1
        if type == 0 {
            svc.type = ReginType.provice
        }else{
            svc.type = ReginType.city
        }
        svc.proIndexBlock = {
                (index:Int?) in
                self.proIndex = index
        }
        svc.selectProIndex = proIndex
        
        svc.doneBlcok = {
            (proModel:RegionModel?,cityModel:RegionModel?,quModel:RegionModel?) in
            self.seletAreaView.cityl.text = cityModel?.title
            self.seletAreaView.prol.text = proModel?.title
            self.proModel = proModel
            self.cityModel = cityModel
            self.page = 1
            self.getResumeList()
        }
        self.present(svc, animated: false, completion: nil)
        
    }
    
}



