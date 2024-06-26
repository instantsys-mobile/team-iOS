//
//  SecondViewController.swift
//  30_May_2024
//
//  Created by DhruvPorwal on 30/05/24.
//

import UIKit

class AutoLayoutVC: UIViewController {
    
    @IBOutlet weak var stackA: UIStackView! {
        didSet {
            // Margin (outer space)
            stackA.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            stackA.isLayoutMarginsRelativeArrangement = true
            
            // Padding (space between arranged subviews)
            stackA.spacing = 10
        }
    }
    
    @IBOutlet weak var stackB: UIStackView! {
        didSet {
            // Margin (outer space)
            stackB.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            stackB.isLayoutMarginsRelativeArrangement = true
            
            // Padding (space between arranged subviews)
            stackB.spacing = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
