

import Foundation
import UIKit

protocol TitleTableViewDelegate: AnyObject {
    func textViewShouldReturn(_ textView: UITextView) -> Bool
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool
}

class TitleCellViewModel {
    
    private let maxCharacterCount = 25 // Adjust as per your requirement
    
    var toolbar: UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolbar.items = [flexibleSpace, doneButton]
        return toolbar
    }
    
    @objc private func didTapDone() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func shouldChangeText(in textView: UITextView, range: NSRange, replacementText text: String) -> Bool {
        // Check if the return key was pressed
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        // Calculate the new text if the replacement is applied
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        // Checking if the new text length exceeds maxCharacterCount
        if textView.tag == 1 && newText.count > maxCharacterCount {
            // Dismiss the keyboard
            textView.resignFirstResponder()
            return false
        }
        
        return true
        // For other text views or characters, allow the replacement
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
