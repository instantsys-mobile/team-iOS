import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    weak var authenticationDelegate: (AuthenticationDelegate)?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var profileImage: UIImage?
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var backToLoginScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let confirmPasswordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Confirm Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField = CustomTextField(placeholder: "Full Name")
    private let userNameTextField = CustomTextField(placeholder: "User Name")
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.654, green: 0.278, blue: 0.831, alpha: 1.0) // Using RGB values for color
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    // Tap gesture recognizer to dismiss keyboard
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        gesture.cancelsTouchesInView = false // Allow other gestures to function alongside this tap gesture
        return gesture
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
        
        // Add tap gesture to dismiss keyboard
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(scrollView)
        scrollView.fillSuperview() // Extension method to constrain scrollView to entire superview
        
        scrollView.addSubview(contentView)
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true // Constrain contentView's width to scrollView's width
        
        contentView.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: contentView)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: contentView.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, confirmPasswordTextField, fullNameTextField, userNameTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        contentView.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        contentView.addSubview(backToLoginScreenButton)
        backToLoginScreenButton.centerX(inView: contentView)
        backToLoginScreenButton.anchor(top: stack.bottomAnchor, bottom: contentView.bottomAnchor, paddingTop: 32, paddingBottom: 16)
    }
    
    // MARK: - ACTIONS
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // Adjusting the content inset of scrollView to move content up
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // Ensuring the active text field is visible
        var visibleRect = contentView.frame
        visibleRect.size.height -= keyboardSize.height
        if let activeField = findActiveTextField() {
            if !visibleRect.contains(activeField.frame.origin) {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // Resetting scrollView insets when keyboard hides
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    // MARK: - Tap Gesture Handling
    
    @objc func handleTapGesture() {
        view.endEditing(true) // Dismisses the keyboard when tapped outside of a text field
    }
    
    // MARK: - Actions
    
    @objc func handleShowLogIn() {
        print("DEBUG: Sign In here..")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleProfilePhotoSelect() {
        print("Present Photo Library")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let fullName = fullNameTextField.text, !fullName.isEmpty else { return }
        guard let userName = userNameTextField.text?.lowercased(), !userName.isEmpty else { return }
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else { return }
        guard let profileImage = self.profileImage else { return }

        if password == confirmPassword {
            AuthService.registerUser(withCredentials: AuthCredentials(email: email, password: password, fullName: fullName, userName: userName, profileImage: profileImage)) { error in
                if let error = error {
                    print("DEBUG \(error.localizedDescription)")
                    // Display alert for error
                    let alert = UIAlertController(title: "Registration Failed", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Registration successful, dismiss the view controller
                    print("Successfully registered")
                    self.authenticationDelegate?.authenticationDidComplete()
                  
                }
            }
        } else {
            print("Passwords do not match")
        }
    }

    
    @objc func textDidChange(sender: UITextField) {
        switch sender {
        case emailTextField:
            print("Text changed through emailTextField")
            viewModel.email = emailTextField.text
        case passwordTextField:
            print("Text changed through passwordTextField")
            viewModel.password = passwordTextField.text
        case fullNameTextField:
            print("Text changed through fullNameTextField")
            viewModel.fullName = fullNameTextField.text
        case confirmPasswordTextField:
            print("Text changed through confirmPasswordTextField")
            viewModel.confirmPassword = confirmPasswordTextField.text
        case userNameTextField:
            print("Text changed through userNameTextField")
            viewModel.userName = userNameTextField.text
        default:
            break
        }
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        // Registering for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Helper method to find the active text field
    private func findActiveTextField() -> UIView? {
        let textFields = [emailTextField, passwordTextField, confirmPasswordTextField, fullNameTextField, userNameTextField]
        return textFields.first(where: { $0.isFirstResponder })
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) // this acts like a dictionary and we are looking for the value/image with .editedImage key
    {
        // this is called once the user has successfully picked his/her image
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        profileImage = selectedImage
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2 // as plus button image is actually still a square button
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true,completion: nil)
    }
}


