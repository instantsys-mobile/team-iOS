import UIKit
import TipKit

class LogoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLabel()
    }
    
    private func configureLabel() {
        // Setting font and text properties of UILabel class
        font = UIFont(name: "Billabong", size: 36) ?? UIFont.boldSystemFont(ofSize: 36)
        text = "InstaClone"
        textColor = .white
        textAlignment = .center
    }
}

