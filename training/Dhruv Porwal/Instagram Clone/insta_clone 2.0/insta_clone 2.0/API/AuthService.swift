import Foundation
import UIKit
import FirebaseAuth
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

struct AuthService {
    // Using register fn to register the user
    
    static func registerUser(withCredentials credentials: AuthCredentials, onCompletionPerform: @escaping (Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("Debug \(error.localizedDescription)")
                    
                    // Display alert for error
                    let alert = UIAlertController(title: "Registration Failed", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    
                    onCompletionPerform(error)
                    return
                }
                
                guard let uid = result?.user.uid else {
                    let error = NSError(domain: "AuthServiceErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get user ID"])
                    
                    // Display alert for error
                    if #available(iOS 13.0, *) {
                        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                            let alert = UIAlertController(title: "Registration Failed", message: "Failed to register user.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        // Fallback for older iOS versions
                        if let keyWindow = UIApplication.shared.keyWindow {
                            let alert = UIAlertController(title: "Registration Failed", message: "Failed to register user.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    onCompletionPerform(error)
                    return
                }

                
                let data: [String: Any] = ["email": credentials.email, "fullname": credentials.fullName, "profileImageUrl": imageUrl, "uid": uid, "username": credentials.userName]
                
                COLLECTION_USERS.document(uid).setData(data, completion: { error in
                    if let error = error {
                        // Display alert for error
                        let alert = UIAlertController(title: "Registration Failed", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                    
                    onCompletionPerform(error)
                })
            }
        }
    }
    
    
    // Using login fn to register the user
    static func logInUser(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) 
    {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
}

