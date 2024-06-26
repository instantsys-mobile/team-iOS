//
//  CustomTextField.swift
//  insta_clone 2.0
//
//  Created by DhruvPorwal on 20/06/24.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    // we will create a custom initializer for our field so removing  override init one
    init(placeholder: String) {
        super.init(frame: .zero) // we still need to call the super init method in custom one also // we will create the frame ourselves whereever we would use it
      
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none
        textColor = .white
        keyboardType = .default
        keyboardAppearance = .dark
        // lets make it transparent as well
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        
        // attributed string is the field which appears when no text is presnt in text field as a place-holder
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
