//
//  MineResumeViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/8.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import RxSwift

public class MineResumeViewController: JobWantBaseViewController {

    var tab:UITableView!
    var infoView:MineResumeInfoView!
    var titles:[String]?
    var dispoase = DisposeBag()
    var resumeModel:MineResumeModel?
    var type:Int?
    var attachment : [String]?
    
    var localUrl:[[String:Any]]!
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布简历"
        if attachment == nil {
            attachment = []
        }
        if localUrl == nil {
            localUrl = []
        }
        
        titles = ["求职意向","工作经验","项目经验","教育经历","附加简历","是否隐藏简历"]
        if type==1 {
            titles = ["求职意向","工作经验","项目经验","教育经历","附加简历"]
            self.title = "简历预览"
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "yulanres"), style: .plain, target: self, action: #selector(loockResume))

        setTableview()
        
        if type==1 {
            self.navigationItem.rightBarButtonItem = nil
            tab.frame = self.view.bounds
            infoView.setDataWithModel(mode: resumeModel)
        }else{
            view.addSubview(setFooterView())
        }
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        setNavBarBackground(titlecolor: UIColor.white, itemcolor: UIColor.white, barcolor: UIColor.init(hex: 0x2F6AFF, alpha: 1))
        if type != 1 {
            getResume()
        }
        
    }

    override public func viewWillDisappear(_ animated: Bool) {
        setNavBarBackground(titlecolor: UIColor.init(hex: 0x494D58, alpha: 1), itemcolor: UIColor.init(hex: 0x494D58, alpha: 1), barcolor: UIColor.white)
    }
    
    @objc func loockResume(){
        let vc = MineResumeViewController()
        vc.type = 1
        vc.resumeModel = resumeModel
        vc.localUrl = localUrl
        vc.attachment = attachment
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MineResumeViewController{
    
    func setTableview() {
        
        tab = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-74-(navigationController?.navigationBar.frame.size.height ?? 0)-UIApplication.shared.statusBarFrame.size.height), style: .grouped)
        self.view.addSubview(tab)
        tab.delegate = self
        tab.dataSource = self
        
        let JobResumeTableViewCell = UINib(nibName: "JobResumeTableViewCell", bundle: BundleTool.getBundle())
        tab.register(JobResumeTableViewCell, forCellReuseIdentifier: "JobResumeTableViewCell")
        
        let MineResumeNoInfoTableViewCell = UINib(nibName: "MineResumeNoInfoTableViewCell", bundle: BundleTool.getBundle())
        tab.register(MineResumeNoInfoTableViewCell, forCellReuseIdentifier: "MineResumeNoInfoTableViewCell")
        
        let MineJobExpectTableViewCell = UINib(nibName: "MineJobExpectTableViewCell", bundle: BundleTool.getBundle())
        tab.register(MineJobExpectTableViewCell, forCellReuseIdentifier: "MineJobExpectTableViewCell")
        
        let MineJobWorkjlTableViewCell = UINib(nibName: "MineJobWorkjlTableViewCell", bundle: BundleTool.getBundle())
        tab.register(MineJobWorkjlTableViewCell, forCellReuseIdentifier: "MineJobWorkjlTableViewCell")
        
        let ResumeFJTableViewCell = UINib(nibName: "ResumeFJTableViewCell", bundle: BundleTool.getBundle())
        tab.register(ResumeFJTableViewCell, forCellReuseIdentifier: "ResumeFJTableViewCell")
        
        tab.estimatedRowHeight=1
        tab.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 88, right: 0)
        
        let bundle = Bundle(for: self.classForCoder)
        infoView = bundle.loadNibNamed("MineResumeInfoView", owner: self, options: nil)?.first as? MineResumeInfoView
        infoView.frame = CGRect(x: 0, y: 0, width: tab.frame.size.width, height: 210)
        tab.tableHeaderView = infoView
        tab.separatorStyle = .none
    }
    
}


extension MineResumeViewController:UITableViewDelegate,UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return  titles!.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==1 {
            return resumeModel?.workExperienceList?.count ?? 0
        }
        if section==2 {
            return resumeModel?.projectExperienceList?.count ?? 0
        }
        if section==3 {
            return resumeModel?.educationExperienceList?.count ?? 0
        }
        if section==5 {
            return  0
        }
        if section==4 {
            if resumeModel?.attachment != nil && resumeModel?.attachment != ""{
                return 1
            }
        }
        
        if section==0 {
            if resumeModel?.industryId == nil || resumeModel?.industryName == nil || resumeModel?.positionId == nil || resumeModel?.positionName == nil {
                return 0
            }else{
                return 1
            }
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobExpectTableViewCell") as! MineJobExpectTableViewCell
            cell.setDataWithModel(mode: resumeModel)
            return cell
        }
        if indexPath.section==1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobWorkjlTableViewCell") as! MineJobWorkjlTableViewCell
            let model = resumeModel?.workExperienceList?[indexPath.row]
            cell.setDataWithWorkModel(mode: model)
            if type==1 {
                cell.desl.numberOfLines = 0
            }
            return cell
        }
        if indexPath.section==2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobWorkjlTableViewCell") as! MineJobWorkjlTableViewCell
            let model = resumeModel?.projectExperienceList?[indexPath.row]
            cell.setDataWithProjectModel(mode: model)
            if type==1 {
                cell.desl.numberOfLines = 0
            }
            return cell
        }
        
        if indexPath.section==3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineJobWorkjlTableViewCell") as! MineJobWorkjlTableViewCell
            let model = resumeModel?.educationExperienceList?[indexPath.row]
            cell.setDataWithEduModel(mode: model)
            if type==1 {
                cell.desl.numberOfLines = 0
            }
            return cell
        }
        
        if indexPath.section==4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResumeFJTableViewCell") as! ResumeFJTableViewCell
            cell.selectblock = {
                (str:String) in
                self.lookResume(str: str)
            }
            
            cell.delblock = {
                (str:String) in
                if let index = self.attachment?.lastIndex(of: str)
                {
                    self.attachment?.remove(at: index)
                    self.tab.reloadData()
                }
            }
            cell.type = type
            
            if resumeModel?.attachment != nil && resumeModel?.attachment != ""{
                var attchArr = resumeModel?.attachment?.components(separatedBy: ",")
                
                if let ata = self.attachment {
                    attchArr?.append(contentsOf: ata)
                }
                
                cell.setData(arr: attchArr)
            }else{
                
                if let ata = self.attachment {
                    cell.setData(arr: ata)
                }
                
            }
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineResumeNoInfoTableViewCell") as! MineResumeNoInfoTableViewCell
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5{
            return 20
        }
        return 10
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        let hv = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
        hv.backgroundColor = UIColor.clear
        hv.text = nil
        hv.textColor = UIColor.init(hex: 0x828896)
        hv.font = UIFont.systemFont(ofSize: 12)
        hv.frame = CGRect.zero
        if section == 5{
            hv.text = "隐藏后除了已申请的职位外，将不会有其他公司看到您的简历"
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20)
            hv.frame = CGRect(x: 16, y: 0, width: view.frame.size.width-32, height: 20)
            view.addSubview(hv)
        }
        
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        if type==1 {
            return false
        }
        if indexPath.section==1 || indexPath.section==2 || indexPath.section==3{
            return true
        }else{
            return false
        }
        
    }


    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
            return "删除"
        }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
        {
            
            if editingStyle == UITableViewCell.EditingStyle.delete {
                
                var request:JobWantReqAPI?
                if indexPath.section==1 {
                    let model = resumeModel?.workExperienceList?[indexPath.row]
                    request = .deleteWorkExperience(["id":model?.id ?? ""])
                }else if indexPath.section==2 {
                    let model = resumeModel?.projectExperienceList?[indexPath.row]
                    request = .deleteProjectExperience(["id":model?.id ?? ""])
                }else if indexPath.section==3 {
                    let model = resumeModel?.educationExperienceList?[indexPath.row]
                    request = .deleteEducationExperience(["id":model?.id ?? ""])
                }
                
                Alert.shared.showAlert(title: "提示", content: "确定要删除该经验么？", containBtnTitle: "确定") {
                    self.deleteExpre(request: request!)
                }
                
            }
        }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type==1 {
            return
        }
        if indexPath.section==0 {
            jobwant()
        }
        if indexPath.section==1 {
            workexpre(model: resumeModel?.workExperienceList?[indexPath.row])
        }
        if indexPath.section==2 {
            projectexpre(model: resumeModel?.projectExperienceList?[indexPath.row])
        }
        if indexPath.section==3 {
            eduexpre(model: resumeModel?.educationExperienceList?[indexPath.row])
        }
    }
   
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bundl = Bundle(for: self.classForCoder)
        let hv = bundl.loadNibNamed("MineResumeHeadView", owner: self, options: nil)?.first as! MineResumeHeadView
        hv.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
        let str = titles![section]
        hv.titlel.text = str
        hv.detaill.text = nil
        hv.btn.tag = section
        hv.btn.isHidden = false
        hv.switchBtn.isHidden = true
        hv.switchBtn.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        if type==1 {
            hv.btn.isHidden = true
            hv.switchBtn.isHidden = true
            hv.detaill.isHidden = true
        }

        if section==0 {
            hv.btn.setImage(BundleTool.getImage(str: "jobedit"), for: .normal)
            hv.detaill.text="(必填)"
        }else{
            hv.btn.setImage(BundleTool.getImage(str: "jobadd"), for: .normal)
        }
        if section==4 {
            hv.detaill.text="添加附件简历（支持word、pdf格式）"
        }
        if section==5 {
            hv.btn.isHidden = true
            hv.switchBtn.isHidden = false
        }
        if resumeModel?.resumeStatus == 2 {
            hv.switchBtn.isOn = true
        }else{
            hv.switchBtn.isOn = false
        }
        hv.btn.addTarget(self, action: #selector(edit(btn:)), for: UIControl.Event.touchUpInside)
        return hv
    }
    
    func setFooterView() -> UIView {
           let fv = UIView()
        fv.frame = CGRect(x: 0, y: tab.frame.maxY, width: tab.frame.size.width, height: 74)
           fv.backgroundColor = .white
           
           let surebtn = UIButton()
           surebtn.setTitle("确定发布", for: .normal)
           surebtn.setTitleColor(.white, for: .normal)
           surebtn.backgroundColor = UIColor.init(hex: 0x2F6AFF)
           surebtn.layer.cornerRadius = 8
           surebtn.layer.masksToBounds = true
           surebtn.frame = CGRect(x: 16, y: 14, width: tab.frame.size.width-32, height: 74-14*2)
           surebtn.tag = 2
           surebtn.addTarget(self, action: #selector(offerSure(btn:)), for: .touchUpInside)
           fv.addSubview(surebtn)
           
           return fv
       }
    
}

extension MineResumeViewController {
 
    @objc func edit(btn:UIButton){
        
        if btn.tag != 0 {
            
        if resumeModel?.industryId == nil || resumeModel?.industryName == nil || resumeModel?.positionId == nil || resumeModel?.positionName == nil {
            showToast(info: "请先完善求职意向~")
            return
        }
            
        }
        
        switch btn.tag {
        case 0:
            jobwant()
            break
            case 1:
                workexpre(model: nil)
            break
            case 2:
                projectexpre(model: nil)
            break
            case 3:
                eduexpre(model: nil)
            break
        default:
            upload()
            break
            
        }
        
    }
    
    func jobwant() {
        let vc = EditMineResumeViewController()
        vc.resumeModel = resumeModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func workexpre(model:workExpreModel?) {
        let vc = EditWorkExpreViewController()
        vc.workModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func projectexpre(model:projectExpreModel?) {
        let vc = ProjectExpreViewController()
        vc.proModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func eduexpre(model:MineEduModel?) {
        let vc = EduExpreViewController()
        vc.eduModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func upload() {
        
        let documentTypes = ["public.content",
                            "public.text",
                            "public.source-code",
                            "public.image",
                            "public.audiovisual-content",
                            "com.adobe.pdf",
                            "com.apple.keynote.key",
                            "com.microsoft.word.doc",
                            "com.microsoft.excel.xls",
                            "com.microsoft.powerpoint.ppt"]

        let document = UIDocumentPickerViewController.init(documentTypes: documentTypes, in: .open)
        document.delegate = self  //UIDocumentPickerDelegate
        self.present(document, animated:true, completion:nil)
    }
    
    func lookLocal(url:URL) {
        let vc = UIDocumentInteractionController(url: url)
        vc.delegate = self
        vc.presentPreview(animated: true)
    }
    
    func lookResume(str:String) {
        
        
        if str.range(of: "http") != nil {
            let vc = LookResumeViewController()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            for item in localUrl {
                  
                let st = item["url"] as! String
                if st == str{
                    let url = item["local"] as! URL
                    lookLocal(url: url)
                }
                
            }
            
            
        }
        
    }
    
    func getResume() {
                JobRequestAPIProvider.rx.request(.getMyResume).mapObject(BaseModel<MineResumeModel>.self).subscribe(onSuccess: { (value) in

            let resuModel = value.result
            self.resumeModel = resuModel
            self.infoView.setDataWithModel(mode: self.resumeModel)
//            if let attstr = self.resumeModel?.attachment{
//                        if attstr != "" {
//
//                            if let atrarr = self.attachment {
//
//                                let attrstr = atrarr.joined(separator: ",")
//
//                                if attrstr != "" {
//                                   self.resumeModel?.attachment = "\(attstr),\(attrstr)"
//                                }
//                            }
//
//
//
//
//                        }else{
//                            if let atrarr = self.attachment {
//
//                                let attrstr = atrarr.joined(separator: ",")
//
//                                if attrstr != "" {
//                                   self.resumeModel?.attachment = attrstr
//                                }
//                            }
//                        }
//
//                }else{
//                    if let atrarr = self.attachment {
//
//                        let attrstr = atrarr.joined(separator: ",")
//
//                        if attrstr != "" {
//                           self.resumeModel?.attachment = attrstr
//                        }
//                    }
//                }
            self.tab.reloadData()
                    

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
                
    }
    
    func deleteExpre(request:JobWantReqAPI) {
               
        JobRequestAPIProvider.rx.request(request).mapObject(BaseModel<MineResumeModel>.self).subscribe(onSuccess: { (value) in

            if value.code == "0"{
                self.getResume()
            }else{
                
            }

        }) { (error) in
            print(error)
        }.disposed(by: dispoase)
                
    }
    
    @objc func offerSure(btn:UIButton){
        

        if resumeModel?.industryId == nil || resumeModel?.industryName == nil || resumeModel?.positionId == nil || resumeModel?.positionName == nil {
            showToast(info: "请先完善求职意向~")
            return
        }
        
        var atstr = resumeModel?.attachment ?? ""
        
        if resumeModel?.attachment != nil && resumeModel?.attachment != ""{
            
            if let ata = attachment {
                let str = ata.joined(separator: ",")
                atstr = "\(atstr),\(str)"
            }
            
        }else{
            
            if let ata = self.attachment {
                atstr = ata.joined(separator: ",")
            }
            
        }
        
        let parm = ["attachment":atstr] as [String : Any]
        
        
        DispatchQueue.main.async {
            Activity.shared.show()
        }
        JobRequestAPIProvider.rx.request(.saveYXZW(parm)).mapJSON().subscribe(onSuccess: { (value) in
            print(value)
            DispatchQueue.main.async {
                Activity.shared.dismiss()
            }
            
            let json = value as! [String:Any]
         print(json)
            let code = json["code"] as? String
         if let cd = code {
         if cd == "0"{
             showToast(info: "保存成功")
            self.attachment = nil
            self.getResume()
            }
            
            }

        }) { (error) in
            DispatchQueue.main.async {
                Activity.shared.dismiss()
            }

        }.disposed(by: dispoase)
        
    }
    
    @objc func switchDidChange(_ btn:UISwitch){
        
        let status = btn.isOn ? "2":"1"
        let parm = ["status":status]
        JobRequestAPIProvider.rx.request(.updateResumeStatus(parm)).mapJSON().subscribe(onSuccess: { (value) in
            
            self.getResume()
            
        }) { (error) in
            
        }.disposed(by: dispoase)
        
    }
}

extension MineResumeViewController:UIDocumentPickerDelegate{
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
               
        let fileName = url.lastPathComponent
        
        let range: Range = fileName.range(of: ".")!
         let location: Int = fileName.distance(from: fileName.startIndex, to: range.upperBound)
        let subStr = fileName.suffix(fileName.count - location)
        
//        if ICouldManager.iCouldEnable() {
            ICouldManager.downloadFile(WithDocumentUrl: url) { (fileData) in
                //fileData：就是我们选择的文件，这里你可以做你想要的操作，我这里是上传到服务
                CommonAPIProvider.rx.request(.uploadDocumetFile(name: fileName, fileData: fileData, type: String(subStr))).mapJSON().subscribe(onSuccess: { (value) in
                    print(value)
                    
                    let dic = value as! [String:Any]
                    let attac = dic["result"] as? String
                    self.attachment?.append(attac ?? "")
            
                    self.localUrl.append(["url":attac ?? "","local":url])
                    
                    self.tab.reloadData()
                    
                }) { (error) in
                    print(error)
                }.disposed(by: self.dispoase)
            }
//        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}


extension MineResumeViewController:UIDocumentInteractionControllerDelegate{
    
    
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    public func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    public func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.bounds
    }
}
