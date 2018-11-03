//
//  AppDelegate.swift
//  Business
//
//  Created by 朱双泉 on 2018/10/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BaiduMapKitTool.shared.authorization()
        notificationAuthorization()
        return true
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
    
    func notificationAuthorization() {
        if #available(iOS 8.0, *) {
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
    }

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

extension AppDelegate {
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}
