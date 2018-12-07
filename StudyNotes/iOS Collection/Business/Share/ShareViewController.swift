//
//  ShareViewController.swift
//  Share
//
//  Created by 朱双泉 on 2018/12/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        print(contentText)
        self.placeholder = "placeholder"
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func didSelectCancel() {
        super.didSelectCancel()
        print(#function)
    }
    
    override func configurationItems() -> [Any]! {
        guard let item0 = SLComposeSheetConfigurationItem() else { return [] }
        item0.title = "title0"
        item0.value = "value0"
        item0.valuePending = true
        item0.tapHandler = {
            print("tap item0")
            item0.valuePending = !item0.valuePending
        }
        guard let item1 = SLComposeSheetConfigurationItem() else { return [] }
        item1.title = "title1"
        item1.value = "value1"
        item1.valuePending = true
        item1.tapHandler = {
            print("tap item1")
            item1.valuePending = !item1.valuePending
        }
        return [item0, item1]
    }

}
