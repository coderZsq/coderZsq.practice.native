//
//  UserManager.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by 朱双泉 on 2023/7/29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
}

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "user_id": auth.uid,
            "is_anonymous": auth.isAnonymous,
            "data_created": Timestamp(),
        ]
        if let email = auth.email {
            userData["email"] = email
        }
        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(),
              let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let isAnonymous = data["is_anonymous"] as? Bool
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dataCreated = data["date_created"] as? Date
        return DBUser(userId: userId, isAnonymous: isAnonymous, email: email, photoUrl: photoUrl, dateCreated: dataCreated)
    }
}
