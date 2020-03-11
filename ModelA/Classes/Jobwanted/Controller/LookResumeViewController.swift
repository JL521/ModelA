//
//  LookResumeViewController.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/16.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit
import WebKit

class LookResumeViewController: JobWantBaseViewController,WKNavigationDelegate {

    var webview:WKWebView!
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "查看简历"
        webview = WKWebView(frame: self.view.bounds)
        webview.navigationDelegate = self
        webview.load(URLRequest(url: (URL(string: url ?? ""))!))
        view.addSubview(webview)
    }
    

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
        // 判断是否是信任服务器证书
        if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodServerTrust {
            // 告诉服务器，客户端信任证书
            // 创建凭据对象
            let card = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            // 告诉服务器信任证书
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, card)
        }
    }

}
