//
//  EntryPointViewController.swift
//  30_May_2024
//
//  Created by DhruvPorwal on 31/05/24.
//

import UIKit
import Lottie

class OnboardingVC: UIViewController {
    
    @IBOutlet var viewA: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnimation()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func strtBtn(_ sender: Any) {
        
        let strtVC = self.storyboard?.instantiateViewController(withIdentifier: "PageControlVC") as! PageControlVC
        
        self.navigationController?.pushViewController(strtVC, animated: true)
    }
    
    func createAnimation() {
        let aniView = LottieAnimationView (name:"animation")
        
        
        // use self as its a good practice to
        aniView.contentMode = .scaleAspectFit
        
        aniView.center = self.viewA.center
        
        aniView.frame = self.viewA.bounds
        
        aniView.loopMode = .loop
        
        aniView.play()
        
        self.viewA.addSubview(aniView)
        
    }
}
