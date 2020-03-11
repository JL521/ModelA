//
//  ColorExtension.swift
//  SugarSwiftExtensions
//
//  Created by ZY on 19/08/07.
//  Copyright (c) 2019 ZY. All rights reserved.
//

import UIKit

extension UIColor {
    
    //color from hex
    public convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static let baseColor = UIColor.init(hex: 0x2f6aff, alpha: 1)
    
    static let background = UIColor.init(hex: 0xE7EFFF, alpha: 1)

    static let textFeildTint = UIColor.init(hex: 0x828896, alpha: 1)

    static let searchBackground = UIColor.init(hex: 0xF3F6FB, alpha: 1)
    
    static let textBg = UIColor.init(hex: 0x95BCFF, alpha: 1)

    static let contentbackground = UIColor.init(hex: 0xF1F6F9, alpha: 1)
    
    static let color_494D58 = UIColor.init(hex: 0x494D58, alpha: 1)

    static let color_828896 = UIColor.init(hex: 0x828896, alpha: 1)
    
    static let color_f1f6f9 = UIColor.init(hex: 0xf1f6f9, alpha: 1)

    static let color_f06261 = UIColor.init(hex: 0xF06261, alpha: 1)
    
    static let color_fd9b46 = UIColor.init(hex: 0xFD9B46, alpha: 1)

    static let color_AEB5C5 = UIColor.init(hex: 0xAEB5C5, alpha: 1)
    
    static let color_DAE2F3 = UIColor.init(hex: 0xDAE2F3, alpha: 1)
    
    static let color_b1b1b1 = UIColor.init(hex: 0xB1B1B1, alpha: 1)

    static let color_fe5245 = UIColor.init(hex: 0xFE5245, alpha: 1)

}
