

import Foundation

struct ProfileHeaderViewModel {
    let user: UserProfile
    
    
    var fullName: String {
        return user.fullname ?? "error"
    }
    
    var profileImageUrl: String {
        return user.profileImageUrl ?? "error"
    }
    
    init(user: UserProfile) {
        self.user = user
    }
    
    
}
