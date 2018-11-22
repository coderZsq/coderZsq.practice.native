//
//  H5ViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

//http://c.m.163.com/nc/article/BVEGO8UT05299OU6/full.html

class H5ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "H5"
    
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
        if let body = allData?["body"] as? String {
            webView.loadHTMLString(body, baseURL: nil)
        }
    }
    
}
