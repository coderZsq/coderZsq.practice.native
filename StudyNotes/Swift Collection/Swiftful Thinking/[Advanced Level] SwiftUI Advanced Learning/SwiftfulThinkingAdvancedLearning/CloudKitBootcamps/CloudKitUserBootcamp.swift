//
//  CloudKitUserBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by 朱双泉 on 2023/5/28.
//

import SwiftUI
import CloudKit

class CloudKitUserBootcampViewModel: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var username: String =  ""
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecorID()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    break
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                    break
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                    break
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                    break
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                    break
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
     
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecorID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.username = name
                }
            }
        }
    }
}

struct CloudKitUserBootcamp: View {
    
    @StateObject private var vm = CloudKitUserBootcampViewModel()
    
    var body: some View {
        VStack {
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Premission: \(vm.permissionStatus.description.uppercased())")
            Text("NAME: \(vm.username)")
        }
    }
}

struct CloudKitUserBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUserBootcamp()
    }
}
