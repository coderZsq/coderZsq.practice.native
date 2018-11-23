//
//  H5ViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

//http://c.m.163.com/nc/article/BVEGO8UT05299OU6/full.html

class H5ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var jsBridge: WebViewJavascriptBridge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "H5"
        
        WebViewJavascriptBridge.enableLogging()
        jsBridge = WebViewJavascriptBridge(webView)
        jsBridge?.setWebViewDelegate(self)
        jsBridge?.registerHandler("ObjC Echo", handler: { (data, responseCallback) in
            print("ObjC Echo")
        })
        
        if let url = URL(string: "http://c.m.163.com/nc/article/BVEGO8UT05299OU6/full.html") {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if (error == nil) {
                    DispatchQueue.main.async {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                        self.dealWithJsonData(jsonData: jsonData)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func dealWithJsonData(jsonData: [String : Any]?) {
        let allData = jsonData?["BVEGO8UT05299OU6"] as? [String : Any]
        if
            var body = allData?["body"] as? String,
            let title = allData?["title"] as? String,
            let source = allData?["source"] as? String,
            let articleTags = allData?["articleTags"] as? String,
            let ptime = allData?["ptime"] as? String,
            let img = allData?["img"] as? [[String: Any]] {
            for i in 0..<img.count {
                let imgItem = img[i]
                let src = imgItem["src"] as? String ?? ""
                let ref = imgItem["ref"] as? String ?? ""
                let alt = imgItem["alt"] as? String ?? ""
                let imgHtml =
                    "<div class=\"img-html\">" +
                        "<img src=\"\(src)\" width=\"20%\">" +
                        "<div class=\"img-title\">\(alt)</div>" +
                "</div>"
                body = body.replacingOccurrences(of: ref, with: imgHtml)
            }
            let titleHtml = "<div id=\"title\">\(title)</div>"
            let subTitleHtml =
                "<div id='subTitle'>" +
                    "<span class='source'>\(source)</span>" +
                    "<span class='articleTags'>\(articleTags)</span>" +
                    "<span class='ptime'>\(ptime)</span>" +
            "</div>"
            if
                let css = Bundle.main.url(forResource: "H5.css", withExtension: nil),
                let js = Bundle.main.url(forResource: "H5.js", withExtension: nil) {
                let cssHtml = "<link href='\(css)' rel='stylesheet'>"
                let jsHtml = "<script src='\(js)'></script>"
                let html =
                    "<html>" +
                        "<head>\(cssHtml)</head>" +
                        "<body>\(titleHtml)\(subTitleHtml)\(body)\(jsHtml)</body>" +
                "</html>"
                webView.loadHTMLString(html, baseURL: nil)
            }
        }
    }
    
    @objc
    func openCamera() {
        let photoVc = UIImagePickerController()
        photoVc.sourceType = .photoLibrary
        present(photoVc, animated: true, completion: nil)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let urlString = request.url?.absoluteString
        let urlHeader = "business://"
        let urlIndex = urlHeader.index(urlHeader.startIndex, offsetBy: urlHeader.count)
        let range = urlString?.range(of: urlHeader)
        let upperBound = range?.upperBound
        if upperBound != nil {
            if let method = urlString?[urlIndex...] {
                let sel = Selector(String(method))
                perform(sel)
            }
        }
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let jsString = "alert('load success')"
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
}
