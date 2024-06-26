//
//  UserService.swift
//  insta_clone 2.0
//
//  Created by DhruvPorwal on 25/06/24.
//

import Foundation
import Firebase

struct UserService {
    static func fetchUser(completionHandler: @escaping(UserProfile) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: NO USER FOUND")
                return
            } else {
                print(snapshot?.data() ?? "NA")
                guard let snapShotDictionary = snapshot?.data() else {
                    return
                }
                
                // Now, let's create a initializer for the initialization of our object
                
//                guard let email = snapShotDictionary["email"] as? String
                
                let user = UserProfile(dictionary: snapShotDictionary)
                completionHandler(user)
//                completionHandler(User(username: snapshot?.data(), profilePhoto: <#T##UIImage#>, updatedStatus: <#T##Bool#>))
            }
        }
        
    }
}
