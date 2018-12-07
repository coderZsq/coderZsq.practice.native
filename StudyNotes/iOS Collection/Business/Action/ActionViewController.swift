//
//  ActionViewController.swift
//  Action
//
//  Created by 朱双泉 on 2018/12/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.imageView
                    provider.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil, completionHandler: { (image, error) in
                        print(image ?? "", #line)
                        OperationQueue.main.addOperation {
                            if let strongImageView = weakImageView {
                                if let image = image as? UIImage {
                                    strongImageView.image = image
                                }
                            }
                        }
                    })
//                    imageFound = true
//                    break
                }
                if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakLabel = self.titleLabel
                    provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (text, error) in
                        DispatchQueue.main.async {
                            if let text = text as? String {
                                weakLabel?.text = text
                            }
                        }
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        let provider = NSItemProvider(item: "done for: action" as NSSecureCoding, typeIdentifier: kUTTypeText as String)
        let item = NSExtensionItem()
        item.attachments = [provider]
        
        guard let image = UIImage(named: "qrcode") else { return }
        let provider1 = NSItemProvider(item: image, typeIdentifier: kUTTypeImage as String)
        let item1 = NSExtensionItem()
        item1.attachments = [provider1]
        
        self.extensionContext!.completeRequest(returningItems: [item, item1], completionHandler: nil)
    }

}
