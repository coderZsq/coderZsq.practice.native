//
//  WebViewController.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: ViewController {
    
    fileprivate lazy var configuretion: WKWebViewConfiguration = { [weak self] in
        let configuretion = WKWebViewConfiguration()
        return configuretion
    }()
    
    fileprivate lazy var webView: WKWebView = { [weak self] in
        let webView = WKWebView(frame: self!.view.bounds)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        return webView
    }()
    
    fileprivate lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 65, width: self.view.bounds.size.width, height: 2))
        progressView.trackTintColor = .clear
        return progressView
    }()
    
    fileprivate var absoluteUrl = ""
    
    init (_ url: String) {
        super.init(nibName: nil, bundle: nil)
        absoluteUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(progressView)
        
        func loadRequest() {
            var request = URLRequest(url: URL(string: absoluteUrl)!)
            request.addValue("skey=skeyValue", forHTTPHeaderField: "Cookie")
            webView.addObserver(self, forKeyPath: "estimatedProgress", options: [.new, .old], context: nil)
            webView.load(request)
        }; loadRequest()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.25, delay: 0.25, options: [.curveEaseOut], animations: {
                    self.progressView.alpha = 0.0
                    }, completion: { (finished) in
                        self.progressView.setProgress(0.0, animated: true)
                })
            }
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

extension WebViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        present(alertViewController, animated: false, completion: nil)
    }
}



