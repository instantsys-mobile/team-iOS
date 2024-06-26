import Foundation

extension UserDefaults {
    enum Keys {
        static let isLoggedIn = "isLoggedIn"
    }
    
    static var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isLoggedIn)
        }
    }
}

