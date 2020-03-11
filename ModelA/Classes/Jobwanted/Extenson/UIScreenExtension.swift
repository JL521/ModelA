//
//  UIScreenExtension.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/24.
//  Copyright © 2019 zhangyu. All rights reserved.
//

extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
