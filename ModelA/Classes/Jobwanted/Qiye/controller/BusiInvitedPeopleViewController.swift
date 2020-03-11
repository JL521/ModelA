//
//  BusiInvitedPeopleViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/18.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class BusiInvitedPeopleViewController: JobWantBaseViewController {

    let titles = ["已通知", "已接受", "已结束"]
    var scale:CGFloat?
    lazy var childVcs:[BusiInvitedPeopleListViewController] = {
        var childVcs = [BusiInvitedPeopleListViewController]()
        
        let watvc = BusiInvitedPeopleListViewController()
        watvc.status = "1"
        childVcs.append(watvc)
        
        let yjs = BusiInvitedPeopleListViewController()
        yjs.status = "2"
        childVcs.append(yjs)
        
        let jsvc = BusiInvitedPeopleListViewController()
        jsvc.status = "3"
        childVcs.append(jsvc)
        
        
        
        return childVcs
    }()
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : YMPageTitleView = {[weak self] in
        
        let statusHeight:CGFloat = screen_height >= 812 ? 44 : 20
        
        let titleFrame = CGRect(x: 0, y: 1, width: screen_width, height: 44)
        let titleView = YMPageTitleView(frame: titleFrame, titles:  self?.titles ?? [], params: (screen_width/3.0-20, 3, UIFont.systemFont(ofSize: 15)), cellWidth: screen_width/3.0, cellSpace: 0, scale: scale != nil ? scale! : 0)
        
        titleView.backgroundColor = .white
        titleView.cellSpace = 0
        titleView.cellWidth = screen_width/3.0
        titleView.delegate = self
        
        return titleView
        }()
    
    fileprivate lazy var pageContentView : YMPageContentView = {[weak self] in
    
    // 1.确定内容的frame
    let contentFrame = CGRect(x: 0, y: pageTitleView.frame.maxY, width: screen_width, height: screen_height - pageTitleView.frame.maxY)
    
    // 2.确定所有的子控制器
    let childVcs = self?.childVcs
    
    let contentView = YMPageContentView(frame: contentFrame, childVcs: childVcs ?? [], parentViewController: self)
    contentView.delegate = self
    return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "邀请的人才"
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentView)
        
    }

}

extension BusiInvitedPeopleViewController: YMPageTitleViewDelegate {
    func classTitleView(_ titleView: YMPageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(index)
        print("选中\(index)")
        
    }
    
    func classTitleViewCurrentIndex(_ titleView: YMPageTitleView, currentIndex index: Int) {
        /// 刷新数据
        print("选中le\(index)")
    }
}

extension BusiInvitedPeopleViewController: YMPageContentViewDelegate {
    func pageContentView(_ contentView: YMPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

