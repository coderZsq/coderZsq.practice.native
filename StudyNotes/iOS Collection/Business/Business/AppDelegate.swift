//
//  AppDelegate.swift
//  Business
//
//  Created by 朱双泉 on 2018/10/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import UserNotifications
//import OOMDetector
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var displayLink: CADisplayLink?
    var window: UIWindow?
    var scheme: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        
//        UserDefaults(suiteName: "相同的suitName")
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            WCSession.default.sendMessage(["iOS" : "send"], replyHandler: { (reply) in
                print(reply)
            }, errorHandler: { (error) in
                print(error)
            })
        }
        
//        OOMDetector.getInstance().setupWithDefaultConfig()
        
        MobClick.setScenarioType(eScenarioType.E_UM_NORMAL)
        MobClick.setCrashReportEnabled(true)
        
        UMConfigure.setEncryptEnabled(true)
        UMConfigure.setLogEnabled(true)
        UMConfigure.initWithAppkey("5be3ca05b465f545560004c5", channel: "App Store")
        let deviceID = UMConfigure.deviceIDForIntegration()
        if deviceID != nil {
            print("服务器成功返回deviceID")
        } else {
            print("服务器还没有返回deviceID")
        }
        
        configUShareSettings()
        configUSharePlatforms()
        
        guard let options = launchOptions else {
            return true
        }
        if options[UIApplication.LaunchOptionsKey.remoteNotification] != nil {
            print("接收到远程推送, 以后, 在这里, 做一些业务逻辑")
        }
//        BaiduMapKitTool.shared.authorization()
        notificationAuthorization()
        jpush(with: launchOptions)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        guard let host = url.host else {return true}
        scheme = url.scheme
        let nav = window?.rootViewController as! UINavigationController
        let root = nav.topViewController
        if host == "inter-app", let vc = UIStoryboard(name: "InterAppViewController", bundle: nil).instantiateInitialViewController() {
                root?.navigationController?.pushViewController(vc, animated: true)
        }
        if host == "extension", let vc = UIStoryboard(name: "ExtensionViewController", bundle: nil).instantiateInitialViewController() {
            root?.navigationController?.pushViewController(vc, animated: true)
        }
        
        let result = UMSocialManager.default()?.handleOpen(url, options: options)
        if result == nil {
            //其他如支付等SDK的回调
        }
        return result ?? true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("接收到通知")
        if application.applicationState == .active {
            print("app 当前处于前台, 此时, 只需要提醒用户信息的数量, 不需要跳转到会话窗口界面")
        } else if application.applicationState == .inactive {
            print("从后台进入到前台, 这时候, 可以跳转到聊天会话窗口")
        }
    }
}

extension AppDelegate {
    
    func jpush(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if #available(iOS 10.0, *) {
            let types = UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.badge.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.carPlay.rawValue
            let entity = JPUSHRegisterEntity()
            entity.types = Int(types)
            JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        } else if #available(iOS 8.0, *) {
            let types = UIUserNotificationType.badge.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        } else {
            JPUSHService.register(forRemoteNotificationTypes: UIRemoteNotificationType.badge.rawValue | UIRemoteNotificationType.sound.rawValue | UIRemoteNotificationType.alert.rawValue, categories: nil)
        }
        JPUSHService.setup(withOption: launchOptions, appKey: "appKey", channel: "App Store", apsForProduction: false)
    }
    
    func notificationAuthorization() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options = UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.badge.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.carPlay.rawValue
            center.delegate = self
            center.requestAuthorization(options: UNAuthorizationOptions(rawValue: options)) { (granted, error) in
                if granted {
                    print("注册成功")
                    center.getNotificationSettings(completionHandler: { (settings) in
                        print(settings)
                    })
                } else {
                    print("注册失败")
                }
            }
        } else if #available(iOS 8.0, *) {
            let category = UIMutableUserNotificationCategory()
            category.identifier = "category"
            let action1 = UIMutableUserNotificationAction()
            action1.identifier = "action1"
            action1.title = "action1"
            action1.activationMode = .foreground
            action1.isAuthenticationRequired = true
            action1.isDestructive = true
            action1.behavior = .textInput
            action1.parameters = [UIUserNotificationTextInputActionButtonTitleKey : "gank"]
            let action2 = UIMutableUserNotificationAction()
            action2.identifier = "action2"
            action2.title = "action2"
            action2.activationMode = .background
            action2.isAuthenticationRequired = true
            action2.isDestructive = false
            let actions: [UIUserNotificationAction] = [action1, action2]
            category.setActions(actions, for: .default)
            let categories: Set<UIUserNotificationCategory> = [category]
            let type = UIUserNotificationType(rawValue: UIUserNotificationType.alert.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.sound.rawValue)
            let settings = UIUserNotificationSettings(types: type, categories: categories)
            UIApplication.shared.registerUserNotificationSettings(settings)
            //注意 我们需要发送一个请求, 获取对应的deviceToken
            //只要调用了一下方法, 系统会自动获取bundle id, uuid 发送请求, 不需要我们做任何处理
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            let type = UIRemoteNotificationType(rawValue: UIRemoteNotificationType.badge.rawValue | UIRemoteNotificationType.alert.rawValue | UIRemoteNotificationType.sound.rawValue)
            UIApplication.shared.registerForRemoteNotifications(matching: type)
        }
    }
}

extension AppDelegate {
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        let request = notification.request
        let content = request.content
        let badge = content.badge
        let body = content.body
        let sound = content.sound
        let subtitle = content.subtitle
        let title = content.title
        if notification.request.trigger is UNPushNotificationTrigger {
            print("iOS 10 前台接收到远程通知" + "\(userInfo)")
        } else {
            print("iOS 10 前台接收到本地通知" + "\(String(describing: badge))" + "\(body)" + "\(String(describing: sound))" + "\(subtitle)" + "\(title)")
        }
        let options = UNNotificationPresentationOptions.alert.rawValue | UNNotificationPresentationOptions.badge.rawValue | UNNotificationPresentationOptions.sound.rawValue
        completionHandler(UNNotificationPresentationOptions.init(rawValue: options))
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let request = response.notification.request
        let content = request.content
        let badge = content.badge
        let body = content.body
        let sound = content.sound
        let subtitle = content.subtitle
        let title = content.title
        if response.notification.request.trigger is UNPushNotificationTrigger {
            print("iOS 10 接收到远程通知" + "\(userInfo)")
        } else {
            print("iOS 10 接收到远程通知" + "\(String(describing: badge))" + "\(body)" + "\(String(describing: sound))" + "\(subtitle)" + "\(title)")
        }
        completionHandler()
    }
}

extension AppDelegate {
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        print(8.0)
        completionHandler()
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print(9.0)
        if identifier == "action1" {
            print("action1")
        }
        completionHandler()
    }
}

extension AppDelegate: JPUSHRegisterDelegate {
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        JPUSHService.handleRemoteNotification(response.notification.request.content.userInfo)
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("接收到通知")
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("接收到通知")
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate {
    
    func configUShareSettings() {
        UMSocialGlobal.shareInstance()?.isUsingWaterMark = true
        UMSocialGlobal.shareInstance()?.isUsingHttpsWhenShareContent = false
    }
    
    func configUSharePlatforms() {
        UMSocialManager.default()?.openLog(true)
        UMSocialManager.default()?.setPlaform(.wechatSession, appKey: "", appSecret: "", redirectURL: "")
        UMSocialManager.default()?.setPlaform(.alipaySession, appKey: "", appSecret: "", redirectURL: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        if result == nil {
            //其他如支付等SDK的回调
        }
        return result ?? true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url)
        if result == nil {
            //其他如支付等SDK的回调
        }
        return result ?? true
    }
}

extension AppDelegate {
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        removeDisplayLink()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        addDisplayLink()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        addDisplayLink()
    }
    
    @objc func updateLockMessage() {
        MusicOperationTool.shared.setupLockMessage()
    }
    
    func addDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateLockMessage))
        if let displayLink = displayLink {
            displayLink.add(to: .current, forMode: .common)
        }
    }
    
    func removeDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        replyHandler(["iOS": "Data Connectivity"])
    }
}
