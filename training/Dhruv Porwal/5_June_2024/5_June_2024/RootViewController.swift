//
//  RootVC.swift
//  5_June_2024
//
//  Created by DhruvPorwal on 05/06/24.
//

import UIKit

class RootVC: UIViewController {

    @IBAction func tableViewBtnAction(_ sender: Any) {
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: TableViewController.self)) as! TableViewController
        
        self.navigationController?.pushViewController(tableVC, animated: true)
        
    }
    @IBAction func loginBtnAction(_ sender: Any) {
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginFormVC") as? LoginFormVC else { return }
        
        self.navigationController?.pushViewController(loginVC, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()

        // Do any additional setup after loading the view.
    }
    
    func configureNavbar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
