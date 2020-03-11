//
//  ScrollView+Refresh.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/10/16.
//  Copyright © 2019 zhangyu. All rights reserved.
//

extension UIScrollView{
    
    func refreshable(headerRefreshCallBack:NoParamCallBack){
        let header = RefreshHeader.init {
            if let headerCallback = headerRefreshCallBack{
                headerCallback()
            }
        }
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        
        self.mj_header = header
    }
}
