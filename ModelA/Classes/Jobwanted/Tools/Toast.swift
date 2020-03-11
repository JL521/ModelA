//
//  Toast.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/24.
//  Copyright © 2019 zhangyu. All rights reserved.
//
import SwiftEntryKit

enum ToastPosition{
    case top
    case bottom
}

struct Toast {
    
    static let shared = Toast()
    
    public func showToast(position:ToastPosition,icon:String = "ic_coffee_light",title:String = "提示",info:String){
       let attributes = setAttributes(position: position)
       showNotificationMessage(attributes: attributes,
                                title: title,
                                desc: info,
                                textColor: .white,
                                imageName: icon)
    }
    
    public func setAttributes(position:ToastPosition) -> EKAttributes{
        var attributes: EKAttributes
        attributes = position == .top ? EKAttributes.topFloat : EKAttributes.bottomFloat
        attributes.displayMode = .light
        attributes.hapticFeedbackType = .success
        attributes.entryBackground = .gradient(
            gradient: .init(
                colors: [EKColor.init(rgb: 0x3B79FE), EKColor.init(rgb: 0x1B2F90)],
                startPoint: .zero,
                endPoint: CGPoint(x: 1, y: 1)
            )
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.3),
                scale: .init(from: 1, to: 0.7, duration: 0.7)
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.5,
                radius: 10
            )
        )
        attributes.statusBar = .dark
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.minEdge),
            height: .intrinsic
        )
        
        return attributes
    }
    
    
    // Bumps a notification structured entry
    private func showNotificationMessage(attributes: EKAttributes,
                                         title: String,
                                         desc: String,
                                         textColor: EKColor,
                                         imageName: String? = nil) {
        let title = EKProperty.LabelContent(
            text: title,
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: textColor,
                displayMode: .light
            ),
            accessibilityIdentifier: "title"
        )
        let description = EKProperty.LabelContent(
            text: desc,
            style: .init(
                font: UIFont.systemFont(ofSize: 14),
                color: textColor,
                displayMode: .light
            ),
            accessibilityIdentifier: "description"
        )
        var image: EKProperty.ImageContent?
        if let imageName = imageName {
            image = EKProperty.ImageContent(
                image: BundleTool.getImage(str: imageName).withRenderingMode(.alwaysTemplate),
                displayMode: .light,
                size: CGSize(width: 35, height: 35),
                tint: textColor,
                accessibilityIdentifier: "thumbnail"
            )
        }
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
