//
//  Activity.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/27.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Activity {
    
    static let shared = Activity()
    let bgview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
    let act = NVActivityIndicatorView(frame: CGRect.init(x:(screen_width-80)/2, y: (screen_height-80)/2, width: 80, height: 80), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 20)
    
    func show(){
        DispatchQueue.main.async {
            self.act.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
            self.act.layer.cornerRadius = 5
            self.act.startAnimating()
            self.bgview.backgroundColor = UIColor.clear
            self.bgview.addSubview(self.act)
            UIApplication.shared.keyWindow?.addSubview(self.bgview)
        }
    }
    
    func dismiss(){
       DispatchQueue.main.async {
            self.act.stopAnimating()
            self.bgview.removeFromSuperview()
        }
    }
    
}


class GifActivity {

    var actView:GitActivityView!
    var contentView:UIView!
    
    static let shared = GifActivity()
    
    var loadingImages:[UIImage]{
        var images = [UIImage]()
        for i in 0...25 {
            if let image = UIImage.init(named: String(format: "03_%05d", i)){
                images.append(image)
            }
        }
        return images
    }
    
    func show(inView:UIView){
        contentView = inView
        let actView = GitActivityView.init(gifImages: loadingImages, frame: inView.bounds)
        actView.backgroundColor = UIColor.init(white: 1, alpha: 1)
        getTopVC()?.view.addSubview(actView)
        actView.gifImageView.startAnimating()
    }
    
    func dismiss(){
        for view in getTopVC()?.view.subviews ?? []{
            if  view.isMember(of: GitActivityView.self){
                view.removeFromSuperview()
            }
        }
    }
   
}

class GitActivityView: UIView {
    
    var gifImageView:UIImageView =  UIImageView.init(frame: CGRect(x: 0, y: 0, width: 120, height: 176))
    
    convenience init(gifImages:[UIImage],frame:CGRect){
        self.init(frame:frame)
        setup(gifImages: gifImages)
    }
    
    func setup(gifImages:[UIImage]){
        
        gifImageView.center = CGPoint.init(x: self.center.x, y: self.center.y - 80)
        gifImageView.animationImages = gifImages
        self.addSubview(gifImageView)
    }
  
}
