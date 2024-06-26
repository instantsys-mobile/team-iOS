//
//  WebViewController.swift
//  30_May_2024
//
//  Created by DhruvPorwal on 02/06/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        // we will add the here, url as well
        
        guard let url = URL(string: "https://instantsys.com/") else {
            return
        }
        
        webView.load(URLRequest(url: url))

        // Do any additional setup after loading the view.
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
