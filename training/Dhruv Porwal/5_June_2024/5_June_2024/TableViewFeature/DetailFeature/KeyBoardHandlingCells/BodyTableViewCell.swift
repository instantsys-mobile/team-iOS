//
//  BodyTableViewCell.swift
//  5_June_2024
//
//  Created by DhruvPorwal on 06/06/24.
//

import UIKit

class BodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textViewRef: UITextView!
    
    static let identifier = "BodyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BodyTableViewCell", bundle: nil)
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

