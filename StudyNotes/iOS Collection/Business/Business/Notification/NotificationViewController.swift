//
//  NotificationViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notification"
    }
    
    @IBAction func sendLocalNotificationButtonClick(_ sender: UIButton) {
        let notification = UILocalNotification()
        notification.alertBody = "Castiel LocalNotification"
        notification.fireDate = Date(timeIntervalSinceNow: 3)
        notification.repeatInterval = .minute
        notification.hasAction = true
        notification.alertAction = "回复"
        notification.alertLaunchImage = ""
        if #available(iOS 8.2, *) {
            notification.alertTitle = "Business"
        }
        notification.soundName = ""
        notification.applicationIconBadgeNumber = 10
        notification.userInfo = ["name":"castiel"]
        notification.category = "category"
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    @IBAction func cancelLocalNotificationButtonClick(_ sender: UIButton) {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    @IBAction func viewLocalNotificationButtonClick(_ sender: UIButton) {
        let notification = UIApplication.shared.scheduledLocalNotifications
        print(notification ?? "")
    }
}
