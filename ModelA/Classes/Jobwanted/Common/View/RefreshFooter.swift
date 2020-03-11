//
//  RefreshFooter.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/29.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh

var refreshingImages:[UIImage]{
    var images = [UIImage]()
    for i in 0...25 {
        if let image = UIImage.init(named: String(format: "refresh_%05d", i)){
            images.append(image)
        }
    }
    return images
}

class RefreshFooter: MJRefreshAutoGifFooter {
   
    override func prepare() {
        super.prepare()
        setImages(refreshingImages, for: .refreshing)
    }
}

class RefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages(refreshingImages, for: .idle)
        setImages(refreshingImages, for: .pulling)
        setImages(refreshingImages, for: .refreshing)
    }
}
