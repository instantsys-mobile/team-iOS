
import Foundation
import UIKit

protocol AuthenticationProtocol {
    
    var formIsValid: Bool {get}
    var buttonBackgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}

// PROTOCOL ORIENTED PROGRAMMING
struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return formIsValid ?  #colorLiteral(red: 0.6540188193, green: 0.2776970565, blue: 0.8313587308, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var confirmPassword: String?
    var fullName: String?
    var userName: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && fullName?.isEmpty == false && userName?.isEmpty == false && password == confirmPassword
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ?  #colorLiteral(red: 0.6540188193, green: 0.2776970565, blue: 0.8313587308, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
