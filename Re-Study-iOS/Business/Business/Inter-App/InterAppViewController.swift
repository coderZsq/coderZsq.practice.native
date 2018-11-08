//
//  Inter-AppViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import Social

class InterAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inter-App"
    }
    
    @IBAction func umengButtonClick(_ sender: UIButton) {
        
    }
    
    @IBAction func socialButtonClick(_ sender: UIButton) {
        if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo) {
            print("请输入新浪微博的用户名和密码")
            return
        }
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo) {
            vc.setInitialText("InitialText")
            vc.add(UIImage(named: "image"))
            vc.completionHandler = { (result) in
                if result == .done {
                    print("分享成功")
                } else {
                    print("用户取消")
                }
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func settingsButtonClick(_ sender: UIButton) {
//        prefs:root=General&path=About
//        prefs:root=General&path=ACCESSIBILITY
//        prefs:root=AIRPLANE_MODE
//        prefs:root=General&path=AUTOLOCK
//        prefs:root=General&path=USAGE/CELLULAR_USAGE
//        prefs:root=Brightness
//        prefs:root=Bluetooth
//        prefs:root=General&path=DATE_AND_TIME
//        prefs:root=FACETIME
//        prefs:root=General
//        prefs:root=General&path=Keyboard
//        prefs:root=CASTLE
//        prefs:root=CASTLE&path=STORAGE_AND_BACKUP
//        prefs:root=General&path=INTERNATIONAL
//        prefs:root=LOCATION_SERVICES
//        prefs:root=ACCOUNT_SETTINGS
//        prefs:root=MUSIC
//        prefs:root=MUSIC&path=EQ
//        prefs:root=MUSIC&path=VolumeLimit
//        prefs:root=General&path=Network
//        prefs:root=NIKE_PLUS_IPOD
//        prefs:root=NOTES
//        prefs:root=NOTIFICATIONS_ID
//        prefs:root=Phone
//        prefs:root=Photos
//        prefs:root=General&path=ManagedConfigurationList
//        prefs:root=General&path=Reset
//        prefs:root=Sounds&path=Ringtone
//        prefs:root=Safari
//        prefs:root=General&path=Assistant
//        prefs:root=Sounds
//        prefs:root=General&path=SOFTWARE_UPDATE_LINK
//        prefs:root=STORE
//        prefs:root=TWITTER
//        prefs:root=FACEBOOK
//        prefs:root=General&path=USAGE prefs:root=VIDEO
//        prefs:root=General&path=Network/VPN
//        prefs:root=Wallpaper
//        prefs:root=WIFI
//        prefs:root=INTERNET_TETHERING
        
        if #available(iOS 10.0, *) {
//            if let text = sender.titleLabel?.text {
//                if let url = URL(string: "Prefs:root=" + text)  {
//                    if let classType = NSClassFromString("LSApplicationWorkspace") as? NSObject.Type {
//                        let instance = classType.init()
//                        let defaultWorkspace = NSSelectorFromString("defaultWorkspace")
//                        instance.perform(defaultWorkspace).takeRetainedValue().perform(Selector(("openSensitiveURL:withOptions:")), with: url)
//                    }
//                }
//            }
        } else {
            if let text = sender.titleLabel?.text {
                if let url = URL(string: "prefs:root=" + text) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func telButtonClick(_ sender: UIButton) {
        //        "tel://10086"
        //        "sms://10086"
        //        "mailTo://10086"
        if let url = URL(string: "tel://10086") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        if let url = URL(string: "https://www.google.com/search?q=%27ADBannerView%27+was+deprecated+in+iOS+10.0&oq=%27ADBannerView%27+was+deprecated+in+iOS+10.0&aqs=chrome..69i57.271j0j4&sourceid=chrome&ie=UTF-8") {
            print(url.scheme ?? "", url.host ?? "", url.path , url.query ?? "")
        }
    }
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let scheme = appDelegate.scheme, let url = URL(string: scheme + "://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func wechatButtonClick(_ sender: UIButton) {
        if let url = URL(string: "weixin://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func BusinessButtonClick(_ sender: UIButton) {
        
        if let url = URL(string: "business://inter-app") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
