//
//  AddressViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/9.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AddressBookUI
import AddressBook
import ContactsUI
import Contacts

class AddressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Address";
    }
    
    
    @IBAction func contactsUIButtonClick(_ sender: UIButton) {
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func contactsButtonClick(_ sender: UIButton) {
        var contactStore = CNContactStore()
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .notDetermined {
            contactStore.requestAccess(for: .contacts) { (granted, error) in
                if granted {
                    print("授权成功")
                } else {
                    print("授权失败")
                }
            }
        }
        
        let request = CNContactFetchRequest(keysToFetch: [CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request) { (contact, stop) in
//                print(contact)
                let name = contact.familyName + contact.givenName
                print(name)
                let phoneNums = contact.phoneNumbers
                for phoneNum in phoneNums {
                    print(phoneNum.value)
                }
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func addressBookUIButtonClick(_ sender: UIButton) {
        let peoplePicker = ABPeoplePickerNavigationController()
        peoplePicker.peoplePickerDelegate = self
        present(peoplePicker, animated: true, completion: nil)
    }
    
    @IBAction func addressBookButtonClick(_ sender: UIButton) {
        if ABAddressBookGetAuthorizationStatus() == .notDetermined {
            print("用户没有决定")
            let ab = ABAddressBookCreate()?.takeRetainedValue()
            ABAddressBookRequestAccessWithCompletion(ab) { (granted, error) in
                if granted {
                    print("授权成功")
                } else {
                    print("授权失败")
                }
            }
        }
        let ab = ABAddressBookCreate()?.takeRetainedValue()
        let peoples = ABAddressBookCopyArrayOfAllPeople(ab)?.takeRetainedValue()
        let count = CFArrayGetCount(peoples)
        for i in 0..<count {
            let person = unsafeBitCast(CFArrayGetValueAtIndex(peoples, i), to: ABRecord.self)
            let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue() as? String ?? ""
            let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String ?? ""
            print(lastName, firstName)
            let phoneNums = ABRecordCopyValue(person, kABPersonPhoneProperty)?.takeRetainedValue() as ABMultiValue
            let num = ABMultiValueGetCount(phoneNums)
            for j in 0..<num {
                let label = ABMultiValueCopyLabelAtIndex(phoneNums, j)?.takeRetainedValue()
                let value = ABMultiValueCopyValueAtIndex(phoneNums, j)?.takeRetainedValue() as? String
                print(label, value)
            }
        }
    }
}

extension AddressViewController: CNContactPickerDelegate {
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("取消选择联系人")
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.familyName + contact.givenName
        print(name)
        let phoneNums = contact.phoneNumbers
        for phoneNum in phoneNums {
            let phone = phoneNum.value as CNPhoneNumber
            print(phone.stringValue)
        }
        print("选择某一个联系人")
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        for contact in contacts {
            let name = contact.familyName + contact.givenName
            print(name)
            let phoneNums = contact.phoneNumbers
            for phoneNum in phoneNums {
                let phone = phoneNum.value as CNPhoneNumber
                print(phone.stringValue)
            }
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelectContactProperties contactProperties: [CNContactProperty]) {
        print("选择多个人属性时调用")
    }
}

extension AddressViewController: ABPeoplePickerNavigationControllerDelegate {
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue() as? String ?? ""
        let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String ?? ""
        print(lastName, firstName)
        let phoneNums = ABRecordCopyValue(person, kABPersonPhoneProperty)?.takeRetainedValue() as? ABMultiValue
        let count = ABMultiValueGetCount(phoneNums)
        for i in 0..<count {
            let label = ABMultiValueCopyLabelAtIndex(phoneNums, i)?.takeRetainedValue()
            let value = ABMultiValueCopyValueAtIndex(phoneNums, i)?.takeRetainedValue() as? String
            print(label, value)
        }
        print("选择联系人时调用")
    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        print("选择联系人某一个属性时调用")
    }
}
