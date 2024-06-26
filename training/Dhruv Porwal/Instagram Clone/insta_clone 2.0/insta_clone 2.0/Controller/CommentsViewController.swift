import UIKit





class CommentsViewController: UIViewController {
    private let viewModel: CommentsViewModel
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Post a comment"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    private var keyboardHeight: CGFloat = 0.0
    private var isKeyboardVisible = false
    


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configure() {
        // Adding titleLabel to the view and anchoring it to the top
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        // Adding tableView to the view and anchoring it below the titleLabel
        view.addSubview(tableView)
        tableView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        // Adding commentTextField to the view
        view.addSubview(commentTextField)
        
        commentTextField.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        commentTextField.centerX(inView: view)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Now we will reload tableView to update data
        updateTableView()
        
        // Keyboard handling
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Tap gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Set text field delegate
        commentTextField.delegate = self
    }
    
    // MARK: - Keyboard Handling
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        if !isKeyboardVisible {
            isKeyboardVisible = true
            keyboardHeight = keyboardFrame.height
            
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y -= self.keyboardHeight
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if isKeyboardVisible {
            isKeyboardVisible = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // We created a general fn to reload the data
    private func updateTableView() {
        tableView.reloadData()
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        let comment = viewModel.comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension 
        // Use automatic dimension for dynamic cell height promoted
    }
}


    extension CommentsViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard let commentText = textField.text, !commentText.isEmpty else {
                textField.resignFirstResponder()
                return true
            }
            
            // Create a new comment
            let newComment = Comment(user: User(username: "owner", profilePhoto: UIImage(named: "pup")!, updatedStatus: true), text: commentText)
            
            // Add the comment to viewModel.comments
            viewModel.addComment(newComment)
            
            // Clear the textField
            textField.text = nil
            
            // Reload tableView to reflect the new comment locally
            updateTableView()
            
            // Dismiss keyboard
            textField.resignFirstResponder()
            
            return true
        }
    }




