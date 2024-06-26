


import Foundation
import UIKit

class TitleTableViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var title: UITextView!
    static let identifier = "TitleTableViewCell"
    var viewModel: TitleCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: "TitleTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.delegate = self
        title.tag = 1 // Assuming this tag is set to identify this specific text view
        viewModel = TitleCellViewModel()
        title.inputAccessoryView = viewModel?.toolbar // Set the toolbar as input accessory view
    }
    
    func configure(with viewModel: TitleCellViewModel) {
        self.viewModel = viewModel
        title.inputAccessoryView = viewModel.toolbar // Update input accessory view if viewModel changes
    }
    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return viewModel?.shouldChangeText(in: textView, range: range, replacementText: text) ?? true
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return viewModel?.textViewShouldEndEditing(textView) ?? true
    }
}

