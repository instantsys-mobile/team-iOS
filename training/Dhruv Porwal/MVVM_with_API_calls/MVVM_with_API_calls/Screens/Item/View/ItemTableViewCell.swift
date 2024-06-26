//
//  ItemTableViewCell.swift
//  MVVM_with_API_calls
//
//  Created by DhruvPorwal on 16/06/24.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundCellView: UIView!
     @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productCategorylabel: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var titlelabel: UILabel!
    
    var product: ItemModel? {
        didSet { // Using observer
            productSettingUp()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func productSettingUp() {
        guard let product else { return }
        titlelabel.text = product.title
        productCategorylabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateBtn.setTitle("\(product.rating.rate)", for: .normal)
        imgOutlet.setImageView(with: product.image)
       
        
    }
    
}
