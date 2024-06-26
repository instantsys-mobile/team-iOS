
import UIKit

class KeyboardHandlingVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    /// MARK: Setting Up Table View
    @IBOutlet var tabelRef: UITableView! {
        didSet {
            /// Registering The Custom Cells in this table View
            self.tabelRef.register(TitleTableViewCell.nib(), forCellReuseIdentifier: "TitleTableViewCell" )
            self.tabelRef.register(BodyTableViewCell.nib(), forCellReuseIdentifier: "BodyTableViewCell")
            self.tabelRef.register(SubmitButtonTableViewCell.nib(), forCellReuseIdentifier: "SubmitButtonTableViewCell")
            
            self.tabelRef.dataSource = self
            self.tabelRef.delegate = self
        }
    }
    
    var keyBoardToolbar: UIToolbar?
    
    override func viewDidLoad() {
        /// Setting the navigation Bar items
        super.viewDidLoad()
        configureNavbar()
        
        /// Setting The KeyBoard Toolbar
        keyBoardToolbar = createToolbar()
        self.hideKeyBoardWhenTappedAround()
        
        /// Setting Up Notification Center Here
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyBoardHandling), name: UIResponder.keyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: #selector(keyBoardHandling), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    /// Creates a custom toolbar
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolbar.items = [ flexibleSpace, doneButton]
        toolbar.sizeToFit()
        return toolbar
    }
    
    func configureNavbar() {
        /// Set the right bar button items
        self.navigationController?.navigationBar.backgroundColor = .yellow
        
        /// Create the left bar button items
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(popViewController))
        
        /// Set the left bar button items
        self.navigationItem.leftBarButtonItems = [leftBarButton]
        
        let titleLabel = UILabel()
        titleLabel.text = "Edit Dot"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: titleLabel.frame.width, height: titleLabel.frame.height))
        titleView.addSubview(titleLabel)
        
        self.navigationItem.titleView = titleView
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDone() {
        view.endEditing(true)
    }
    
    @objc func keyBoardHandling(notification: Notification) {
        let userinfo = notification.userInfo!
        let keyboardScreenEndFrame = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewendFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tabelRef.contentInset = UIEdgeInsets.zero
        } else {
            tabelRef.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewendFrame.height, right: 0)
            tabelRef.scrollIndicatorInsets = tabelRef.contentInset
        }
    }
}

extension KeyboardHandlingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalHeight = tableView.frame.height
        let numberOfCells = CGFloat(3)
        
        /// Calculate the height for each cell
        let cellHeight: CGFloat = totalHeight / numberOfCells
        if indexPath.row == 1 {
            return cellHeight * 2
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
            cell.configure(with: TitleCellViewModel())
            // cell.delegate = self // Set the delegate to handle actions if needed
            return cell
        }
        if indexPath.row == 1 {
            guard let bodyCell = tabelRef.dequeueReusableCell(withIdentifier: BodyTableViewCell.identifier,for: indexPath) as? BodyTableViewCell  else {
                return UITableViewCell()
            }
            bodyCell.textViewRef.delegate = self
            bodyCell.textViewRef.inputAccessoryView = self.keyBoardToolbar
            return bodyCell
        }
        if indexPath.row == 2 {
            guard let buttonCell = tabelRef.dequeueReusableCell(withIdentifier: SubmitButtonTableViewCell.identifier,for: indexPath) as? SubmitButtonTableViewCell  else {
                return UITableViewCell()
            }
            buttonCell.delegate = self
            return buttonCell
        }
        return UITableViewCell()
    }
}

extension KeyboardHandlingVC: ButtonCellDelegate {
    
    func didTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension KeyboardHandlingVC: TitleTableViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let cell = textView.superview?.superview as? TitleTableViewCell else {
            return true // Default behavior if the textView's superview is not a TitleTableViewCell
        }
        
        return cell.textView(textView, shouldChangeTextIn: range, replacementText: text)
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
}


