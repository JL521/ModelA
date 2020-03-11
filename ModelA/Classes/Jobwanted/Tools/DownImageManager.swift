//
//  DownImageManager.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/10/10.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Foundation

class DownImageManager:NSObject{
    
    static let manager = DownImageManager()
    
    func saveImageToAlbum(image:UIImage,target:AnyObject){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            showToast(info: "保存失败")
            return
        }
        showToast(position: .top,info: "下载成功，请去相册查看")
    }

}



