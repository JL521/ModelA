//
//  Alert.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/28.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import SwiftEntryKit

struct Alert {
    
    static let shared = Alert()
    
    public func showAlert(title:String = "提示",content:String? = nil,containBtnTitle:String = "确认",containCallBack:NoParamCallBack){
        showAlertView(attributes: getAttributes(), title: title, content: content, containBtnTitle: containBtnTitle,hasCancelBtn: true,callBack: containCallBack, cancelCallBack: nil)
    }
    
    public func showSingleTitleAlert(title:String = "提示",content:String? = nil,containBtnTitle:String = "确认",containCallBack:NoParamCallBack){
        showAlertView(attributes: getAttributes(), title: title, content: content, containBtnTitle: containBtnTitle,hasCancelBtn: false,callBack: containCallBack, cancelCallBack: nil)
    }
    
    public func showSingleImageAlert(title:String = "提示",imageName:String,content:String? = nil,containBtnTitle:String = "确认",cancelTitle:String = "取消",hasCancelBtn:Bool = false,containCallBack:NoParamCallBack,cancelCallBack:NoParamCallBack = nil){
        showAlertView(attributes: getAttributes(), imageName: imageName, title: title, content: content, containBtnTitle: containBtnTitle,cancelTitle: cancelTitle,hasCancelBtn: hasCancelBtn, callBack: containCallBack, cancelCallBack: cancelCallBack)
    }
    
    func getAttributes() -> EKAttributes {
        // Preset V
        var attributes: EKAttributes
        attributes = .centerFloat
        attributes.displayMode = .light
        attributes.windowLevel = .alerts
        attributes.displayDuration = .infinity
        attributes.hapticFeedbackType = .success
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        attributes.screenBackground = .color(color: EKColor.init(UIColor.init(white: 0, alpha: 0.6)))
        attributes.entryBackground = .color(color: .white)
        attributes.entranceAnimation = .init(
            scale: .init(
                from: 0.9,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            fade: .init(
                from: 0,
                to: 1,
                duration: 0.3
            )
        )
        attributes.exitAnimation = .init(
            fade: .init(
                from: 1,
                to: 0,
                duration: 0.2
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 5
            )
        )
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.minEdge),
            height: .intrinsic
        )
        
        return attributes
    }
    
    private func showAlertView(attributes: EKAttributes,imageName:String? = nil,title:String,content:String? = nil,containBtnTitle:String,cancelTitle:String = "取消",hasCancelBtn:Bool = false,callBack:NoParamCallBack,cancelCallBack:NoParamCallBack) {
        var image:EKProperty.ImageContent? = nil
        if imageName != nil{
            image = EKProperty.ImageContent(
                imageName: imageName ?? "",
                displayMode: .light,
                size: nil,
                contentMode: .scaleAspectFit
            )
        }
        
        let title = EKProperty.LabelContent(
            text: title,
            style: .init(
                font: UIFont.systemFont(ofSize: 20),
                color: .black,
                alignment: .center,
                displayMode: .light
            )
        )
        
        let description = EKProperty.LabelContent(
            text: content ?? "",
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: EKColor.init(UIColor.color_828896),
                alignment: .center,
                displayMode: .light
            )
        )
        
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let buttonFont = UIFont.boldSystemFont(ofSize: 17)
        
        let okButtonLabelStyle = EKProperty.LabelStyle(
            font: buttonFont,
            color: EKColor.init(UIColor.baseColor),
            displayMode: .light
        )
        let okButtonLabel = EKProperty.LabelContent(
            text: containBtnTitle,
            style: okButtonLabelStyle
        )
        let okButton = EKProperty.ButtonContent(
            label: okButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: EKColor.init(UIColor.baseColor).with(alpha: 1),
            displayMode: .light) {
                if let back = callBack{
                    back()
                    if containBtnTitle == "去更新" {
                        
                    }else{
                        SwiftEntryKit.dismiss()
                    }
                }
        }
        
        var buttons = [EKProperty.ButtonContent]()
        
        if hasCancelBtn {
            
            let cancelButtonLabelStyle = EKProperty.LabelStyle(
                font: buttonFont,
                color: EKColor.init(UIColor.color_494D58),
                displayMode: .light
            )
            
            let cancelButtonLabel = EKProperty.LabelContent(
                text: cancelTitle,
                style: cancelButtonLabelStyle
            )
            let cancelButton = EKProperty.ButtonContent(
                label: cancelButtonLabel,
                backgroundColor: .clear,
                highlightedBackgroundColor: EKColor.init(UIColor.color_494D58).with(alpha: 1),
                displayMode: .light) {
                    if let callBack = cancelCallBack{
                        callBack()
                    }
                    SwiftEntryKit.dismiss()
            }
            buttons.append(cancelButton)
        }
        buttons.append(okButton)
        // Generate the content
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: buttons,
            separatorColor: EKColor.init(rgb: 0xB5b6b5).with(alpha: 0.5),
            displayMode: .light,
            expandAnimatedly: true
        )
        let alertMessage = EKAlertMessage(
            simpleMessage: simpleMessage,
            buttonBarContent: buttonsBarContent
        )
        let contentView = EKAlertMessageView(with: alertMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    
}



