//
//  UITableview+Refresh.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/17.
//  Copyright © 2019 zhangyu. All rights reserved.
//

private var kPage = "kPage"

import UIKit
import MJRefresh
typealias NoParamCallBack = (()->())?

//MARK: - 上拉加载下拉刷新设置
extension UITableView{
    
    func getSource(page:UInt){
        objc_setAssociatedObject(self, &kPage, page, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func refreshable(headerRefreshCallBack:NoParamCallBack,footerRefreshCallBack:NoParamCallBack){
        
        guard var page = objc_getAssociatedObject(self, &kPage) as? UInt else{
                return
        }
        
        let header = RefreshHeader.init {
            if let headerCallback = headerRefreshCallBack{
                page =  1
                objc_setAssociatedObject(self, &kPage, page, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                headerCallback()
            }
        }
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        
        self.mj_header = header
      
        self.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            if let footerCallBack = footerRefreshCallBack{
                page = page + 1
                objc_setAssociatedObject(self, &kPage, page, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                footerCallBack()
            }
        })
    }
    
    func currentPage() -> UInt {
        guard let page = objc_getAssociatedObject(self, &kPage) as? UInt else {
            return 0
        }
        return  page
    }
    
    func resetNoMoreData() {
        if self.mj_footer != nil {
            self.mj_footer?.resetNoMoreData()
        }
    }
    
    func endRefresh(loadNoData:Bool = false){
        if self.mj_header == nil || self.mj_footer == nil{
            return
        }
        
        if self.mj_header?.state == .refreshing {
            self.mj_header?.endRefreshing()
        }
        
        if self.mj_footer?.state == .refreshing || loadNoData{
            if loadNoData{
                self.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                self.mj_footer?.endRefreshing()
            }
        }
    }
}
