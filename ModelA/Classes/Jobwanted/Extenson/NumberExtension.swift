//
//  NumberExtension.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/10/12.
//  Copyright © 2019 zhangyu. All rights reserved.
//

let format = "%.2f"
let intFormat = "%.0f"

extension Int {
    var toString:String?{
        return  String(format: "%d", self)
    }
}

extension Float {
    var toString:String{
        return  String(format: format, self)
    }
    
    var toIntString:String{
        return  String(format: intFormat, self)
    }
}

extension CGFloat {
    var toString:String{
        return  String(format: format, self)
    }
}
