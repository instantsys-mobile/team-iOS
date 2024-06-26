import UIKit

class LoginFormVC: UIViewController {
    
    var activeTextField:UITextField!
    
    @IBOutlet weak var scrollController: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var ssn: UITextField!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var colony: UITextField!
    @IBOutlet weak var landmarkNearby: UITextField!
    @IBOutlet weak var identity: UITextField!
    @IBOutlet weak var town: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavbar()
        /// Doing any additional setup after loading the view.
        /// Set delegates and tags for all text fields
        self.name.delegate = self
        self.name.tag = 1
        self.address.delegate = self
        self.address.tag = 2
        self.phoneNo.delegate = self
        self.phoneNo.tag = 3
        self.emailId.delegate = self
        self.emailId.tag = 4
        self.dateOfBirth.delegate = self
        self.dateOfBirth.tag = 5
        self.ssn.delegate = self
        self.ssn.tag = 9
        self.pincode.delegate = self
        self.pincode.tag = 14
        self.area.delegate = self
        self.area.tag = 13
        self.colony.delegate = self
        self.colony.tag = 11
        self.landmarkNearby.delegate = self
        self.landmarkNearby.tag = 12
        self.identity.delegate = self
        self.identity.tag = 10
        self.town.delegate = self
        self.town.tag = 8
        self.city.delegate = self
        self.city.tag = 7
        self.country.delegate = self
        self.country.tag = 6
        
        name.becomeFirstResponder()
        
        self.hideKeyBoardWhenTappedAround()
        
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: #selector(keyBoard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        /// Setting up input accessory view toolbar for all text fields
        let keyBoardToolbar = createToolbar()
        self.name.inputAccessoryView = keyBoardToolbar
        self.address.inputAccessoryView = keyBoardToolbar
        self.phoneNo.inputAccessoryView = keyBoardToolbar
        self.emailId.inputAccessoryView = keyBoardToolbar
        self.dateOfBirth.inputAccessoryView = keyBoardToolbar
        self.ssn.inputAccessoryView = keyBoardToolbar
        self.pincode.inputAccessoryView = keyBoardToolbar
        self.area.inputAccessoryView = keyBoardToolbar
        self.colony.inputAccessoryView = keyBoardToolbar
        self.landmarkNearby.inputAccessoryView = keyBoardToolbar
        self.identity.inputAccessoryView = keyBoardToolbar
        self.town.inputAccessoryView = keyBoardToolbar
        self.city.inputAccessoryView = keyBoardToolbar
        self.country.inputAccessoryView = keyBoardToolbar
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let prevButton = UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .plain, target: self, action: #selector(moveToPreviousField))
        let nextButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(moveToNextField))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolbar.items = [prevButton, nextButton, flexibleSpace, doneButton]
        toolbar.sizeToFit()
        return toolbar
    }
    
    func configureNavbar() {
        /// Set the right bar button item
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: #selector(popViewController)),
            UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(popViewController))
        ]
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(popViewController)),
        ]
        self.navigationItem.title = "Login Page"
    }

    @objc func showOptions() {
        // In Menu we handle options here
    }

    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func keyBoard(notification: Notification) {
        let userinfo = notification.userInfo!
        let keyboardScreenEndFrame = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewendFrame = view.convert(keyboardScreenEndFrame,from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollController.contentInset = UIEdgeInsets.zero
        } else {
            scrollController.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewendFrame.height, right: 0)
            scrollController.scrollIndicatorInsets = scrollController.contentInset
        }
    }
    
    @objc func didTapDone() {
        view.endEditing(true)
    }
    
    // Action method for moving to the previous text field
    @objc func moveToPreviousField() {
        if let currentTextField = findFirstResponder(),
           let previousTextField = view.viewWithTag(currentTextField.tag - 1) as? UITextField {
            previousTextField.becomeFirstResponder()
        }
    }
    
    // Action method for moving to the next text field
    @objc func moveToNextField() {
        if let currentTextField = findFirstResponder(),
           let nextTextField = view.viewWithTag(currentTextField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        }
    }
    
    func findFirstResponder() -> UITextField? {
        print("Func hit")
        for subview in view.subviews {
            if let textField = findTextFieldInView(subview) {
                print("Found first responder. Tag: \(textField.tag)")
                return textField
            }
        }
        print("No first responder found")
        return nil
    }
    
    func findTextFieldInView(_ view: UIView) -> UITextField? {
        for subview in view.subviews {
            if let textField = subview as? UITextField, textField.isFirstResponder {
                return textField
            } else if let nestedTextField = findTextFieldInView(subview) {
                return nestedTextField
            }
        }
        return nil
    }
}

extension UIViewController {
    func hideKeyBoardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginFormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
}
