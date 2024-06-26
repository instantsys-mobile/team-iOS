import UIKit


struct User {
    let username: String
    let profilePhoto: UIImage
    var updatedStatus: Bool
    var email: String?
    var fullname: String?
    var profileImageUrl: String?
    var uid: String?
}

struct UserProfile {
    let username: String
    var email: String?
    var fullname: String?
    var profileImageUrl: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? " "
        self.username = dictionary["username"] as? String ?? " "
        self.fullname = dictionary["fullname"] as? String ?? " "
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? " "
        self.uid = dictionary["uid"] as? String ?? " "
    }
}

class Post {
    let user: User
    let postImage: UIImage
    var likes: Int
    var comments: [Comment]
    let caption: String
    var isLiked: Bool
    let tag: String
    
    init(user: User, postImage: UIImage, likes: Int, comments: [Comment], caption: String, isLiked: Bool = false, tag: String) {
        self.user = user
        self.postImage = postImage
        self.likes = likes
        self.comments = comments
        self.caption = caption
        self.isLiked = isLiked
        self.tag = tag
    }
}

struct Comment {
    let user: User
    let text: String
}

struct Story {
    let imageName: String
    let caption: String?
    let duration: TimeInterval
    let timestamp: Date
}

