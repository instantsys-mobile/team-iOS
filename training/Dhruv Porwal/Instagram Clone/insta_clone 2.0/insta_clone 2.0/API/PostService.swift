
import Foundation
import UIKit
import Firebase

struct PostService {
    static func fetchPosts() {
        Firestore.firestore().collection("posts").getDocuments { (snapshot, error) in
            guard let docs = snapshot?.documents else {return}
            
            docs.forEach { doc  in
                print("\(doc.data())")
            }
        }
    }
}
