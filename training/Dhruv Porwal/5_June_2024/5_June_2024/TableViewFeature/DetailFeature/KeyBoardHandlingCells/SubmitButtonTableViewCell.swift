//
//  ButtonTableViewCell.swift
//  5_June_2024
//
//  Created by DhruvPorwal on 06/06/24.
//

import UIKit

class SubmitButtonTableViewCell: UITableViewCell {
    
    static let identifier = "SubmitButtonTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SubmitButtonTableViewCell", bundle: nil)
    }
    
    weak var delegate: ButtonCellDelegate?
    
    @IBAction func BtnAction(_ sender: Any) {
        delegate?.didTapButton()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol ButtonCellDelegate: AnyObject {
    func didTapButton()
}
