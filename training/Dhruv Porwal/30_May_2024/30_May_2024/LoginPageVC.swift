import UIKit

class LoginPageVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var aboutUsField: UITextView!
    
    var activeTextField:UITextField!
    var validFlagE = false
    var validFlagN = false
    var validFlagP = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aboutUsField.delegate = self
        self.emailOutlet.delegate = self
        self.nameField.delegate = self
        self.phoneField.delegate = self
        
        // Do any additional setup after loading the view.
        let center: NotificationCenter = NotificationCenter.default
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
        
        center.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        center.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardShown(notification: Notification) {
        
        guard let aboutusTextView = self.view.viewWithTag(10) as? UITextView,
              aboutusTextView.isFirstResponder else {
            return
        }
        
        self.view.frame.origin.y = 10
        if let keyBoardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyBoardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (submitBtn.frame.origin.y)
            
            self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
        }
        
    }
    
    @objc func keyboardHide() {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func submitButton(_ sender: Any) {
        validateFields()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validateFields() {
        guard let email = emailOutlet.text,
              let name = nameField.text,
              let phone = phoneField.text else {
            // Handle case where email, name, or phone text field is nil
            return
        }
        
        if email.isValidEmail() {
            print("Valid email!")
            validFlagE = true
        } else {
            print("Invalid email!")
            openAlert(title: "Alert", message: "Invalid Email Address", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in print("Okay Clicked !")}])
            return
        }
        
        if name.isValidName() {
            print("Valid name!")
            validFlagN = true
        } else {
            print("Invalid name!")
            openAlert(title: "Alert", message: "Name Cannot Be Empty or More Than 25 Characters", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in print("Okay Clicked !")}])
            return
        }
        
        if phone.isValidPhoneNumber() {
            print("Valid phone number!")
            validFlagP = true
        } else {
            print("Invalid phone number!")
            openAlert(title: "Alert", message: "Invalid Phone Number", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in print("Okay Clicked !")}])
            return
        }
        
        if validFlagE == true && validFlagN == true && validFlagN == true {
            openAlert(title: "Alert", message: "Successfully Logged In", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in print("Okay Clicked !")}])
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameField {
            // Check if the new length after replacement exceeds the limit
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 32
        }
        
        if textField == phoneField {
            // Check if the new length after replacement exceeds the limit
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 10
        }
        
        if textField == emailOutlet {
            // Check if the new length after replacement exceeds the limit
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 26
        }
        
        return true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}


// Extension for implementing Alerts

extension UIViewController {
    
    public func  openAlert(title: String,
                           message: String,
                           alertStyle: UIAlertController.Style,
                           actionTitles: [String],
                           actionStyles: [UIAlertAction.Style],
                           actions: [((UIAlertAction) -> Void)]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController,animated: true)
        
    }
}

extension String {
    func isValidEmail() -> Bool {
        // Regular expression to validate email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        return self.count <= 32
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = "^\\d{10}$" // Regular expression for 10 digit phone number
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
}

