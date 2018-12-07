//
//  ExtensionViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/12/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MobileCoreServices

class ExtensionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Extension"
        let d = UserDefaults(suiteName: "group.business")
        print(d?.value(forKey: "key") ?? "")
    }
   
    @IBAction func actionButtonClick(_ sender: UIButton) {
        let image = UIImage(named: "Castiel")!
        let vc = UIActivityViewController(activityItems: [image, "Castiel"], applicationActivities: nil)
        weak var weakImageView = self.imageView
        vc.completionWithItemsHandler = { (activityType, complete, returnedItems, activityError) in
            if activityError == nil {
                if complete == true && returnedItems != nil {
                    for item in returnedItems! {
                        if let item = item as? NSExtensionItem {
                            for provider in item.attachments! {
                                if provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                                    provider.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil, completionHandler: { (img, error) in
                                        OperationQueue.main.addOperation {
                                            if let strongImageView = weakImageView {
                                                if let img = img as? UIImage {
                                                    strongImageView.image = img
                                                }
                                            }
                                        }
                                    })
                                } else if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                                    provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (text, error) in
                                        guard error == nil else {
                                            print(error!)
                                            return
                                        }
                                        print(text!)
                                    })
                                }
                            }
                        }
                    }
                }
            } else {
                print(activityError!)
            }
        }
        present(vc, animated: true, completion: nil)
    }
}
