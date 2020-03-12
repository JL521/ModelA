//
//  Tableview+EmptyView.swift
//  NVRCloudIOS
//
//  Created by Nvr on 2018/9/27.
//  Copyright © 2018年 zhangyu. All rights reserved.
//

import UIKit

extension UITableView {
    

    func emptyCheck(image: UIImage? = UIImage.init(named: "nodata"), title: String? = "暂无数据哦~", isGroup: Bool = false,btnTitle:String? = nil,functionCallBack:NoParamCallBack = nil) {

        for view in self.subviews {
            if view.isKind(of: EmptyView.self) {
                view.removeFromSuperview()
            }
        }

        if isEmpty(isGroup: isGroup) {
            if let emptyView =  BundleTool.getBundle().loadNibNamed("EmptyView", owner: self, options: [:])?.last as? EmptyView {
                emptyView.frame = self.bounds
                emptyView.noDataImageView.image = image
                emptyView.noDataTitle.text = title
                if btnTitle != nil {
                    emptyView.functionBtn.setTitle(btnTitle, for: .normal)
                    emptyView.funcCallBack = functionCallBack
                }
                self.addSubview(emptyView)
                self.bringSubviewToFront(emptyView)
            }
            if self.mj_header != nil {
                self.mj_header?.isHidden = true
            }
            
            if self.mj_footer != nil {
                self.mj_footer?.isHidden = false
            }
        } else {
            if self.mj_header != nil {
                self.mj_header?.isHidden = false
            }
            
            if self.mj_footer != nil {
                self.mj_footer?.isHidden = false
            }

        }
    }

    //验证tableview是否有数据
    func isEmpty(isGroup: Bool) -> Bool {

        var isEmpty = true
        let scr = self.dataSource
        var sections = 0

        //得到tableView分组数
        if isGroup == true {
            sections = (scr?.numberOfSections!(in: self))!
        } else {
            if (scr?.responds(to: #selector(getter: numberOfSections)))! {
                sections = (scr?.numberOfSections!(in: self))!
            }
        }

        if isGroup == true && sections == 0 {
            return true
        }

        //遍历每组行数，如果有就说明有数据
        for i in 0...sections {
            let rows = scr?.tableView(self, numberOfRowsInSection: i)
            if rows! > 0 {
                isEmpty = false
            }
        }

        return isEmpty
    }

    func emptyCheckWithIsNoData(image: UIImage? = UIImage.init(named: "nodata"), title: String? = "暂无数据哦~", isNoData: Bool = false,btnTitle:String? = nil,functionCallBack:NoParamCallBack = nil) {

        for view in self.subviews {
            if view.isKind(of: EmptyView.self) {
                view.removeFromSuperview()
            }
        }

        if isNoData {
            if let emptyView =  BundleTool.getBundle().loadNibNamed("EmptyView", owner: self, options: [:])?.last as? EmptyView {
                emptyView.frame = self.bounds
                emptyView.noDataImageView.image = image
                emptyView.noDataTitle.text = title
                if btnTitle != nil {
                    emptyView.functionBtn.setTitle(btnTitle, for: .normal)
                    emptyView.funcCallBack = functionCallBack
                }
                self.addSubview(emptyView)
                self.bringSubviewToFront(emptyView)
            }
            if self.mj_header != nil {
                self.mj_header?.isHidden = true
                self.mj_footer?.isHidden = true
            }
        } else {
            if self.mj_header != nil {
                self.mj_header?.isHidden = false
                self.mj_footer?.isHidden = false
            }
        }
    }
    
}

extension UICollectionView{
    
    func emptyCheck(image: UIImage? = UIImage.init(named: "nodata"), title: String? = "暂无数据哦~", isGroup: Bool = false,btnTitle:String? = nil,functionCallBack:NoParamCallBack = nil) {

          for view in self.subviews {
              if view.isKind(of: EmptyView.self) {
                  view.removeFromSuperview()
              }
          }

          if isEmpty(isGroup: isGroup) {
              if let emptyView =  BundleTool.getBundle().loadNibNamed("EmptyView", owner: self, options: [:])?.last as? EmptyView {
                  emptyView.noDataImageView.image = image
                  emptyView.noDataTitle.text = title
                  if btnTitle != nil {
                      emptyView.functionBtn.setTitle(btnTitle, for: .normal)
                      emptyView.funcCallBack = functionCallBack
                  }
                   emptyView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
                  self.addSubview(emptyView)
                  self.bringSubviewToFront(emptyView)
              }
              if self.mj_header != nil {
                self.mj_header?.isHidden = true
                self.mj_footer?.isHidden = true
              }
          } else {
              if self.mj_header != nil {
                self.mj_header?.isHidden = false
                self.mj_footer?.isHidden = false
              }
          }
      }

      //验证tableview是否有数据
      func isEmpty(isGroup: Bool) -> Bool {

          var isEmpty = true
          let scr = self.dataSource
          var sections = 0

          //得到tableView分组数
          if isGroup == true {
              sections = (scr?.numberOfSections!(in: self))!
          } else {
              if (scr?.responds(to: #selector(getter: numberOfSections)))! {
                  sections = (scr?.numberOfSections!(in: self))!
              }
          }

          if isGroup == true && sections == 0 {
              return true
          }

          //遍历每组行数，如果有就说明有数据
          for i in 0...sections {
            let rows = scr?.collectionView(self, numberOfItemsInSection: i)
              if rows! > 0 {
                  isEmpty = false
              }
          }

          return isEmpty
      }
    
    
    
    
    
}
