//
//  ViewController.swift
//  29-May-Assignment
//
//  Created by DhruvPorwal on 29/05/24.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var selectedItemImg: UIImageView!
   
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var selectedItem: UILabel! {
        didSet {
            selectedItem.isHidden = true
        }
    }
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.isHidden = true
        }
    }
    @IBOutlet weak var progressBar: UIProgressView! {
        didSet {
            progressBar.isHidden = true
        }
    }
    @IBOutlet weak var progressView: UIActivityIndicatorView! {
        didSet {
            progressView.isHidden = true
        }
    }
    
    var secsRemain = 0
    var codeModel = CodeModel()
    var timer = Timer()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Accessing items from CodeModel
        // Accessing the items array
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func startAction(_ sender: Any) {
        
        
        startButtonOutlet.isHidden = true
        
        
        // Show the progress view and start animating
        progressView.isHidden = false
        progressBar.isHidden = false
        progressView.startAnimating()
        
        progressBar.progress = 0.0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        
        if secsRemain > 10 {
            timer.invalidate()
            
            pickerView.isHidden = false
            progressBar.isHidden = true
            progressView.isHidden = true
            selectedItemImg.isHidden = false
            selectedItemImg.image = codeModel.items[0].image
            
            
            
            
        } else {
            secsRemain += 1
            let percentageProgress = Float(secsRemain) / 10.0
            progressBar.progress = percentageProgress
        }
    }
    
    @IBAction func stopAction(_ sender: Any) {
        // Stop animating and hide the progress view
        progressView.stopAnimating()
        progressView.isHidden = true
        timer.invalidate()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return codeModel.items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return codeModel.items[row].label
    }
    
    // Inside ViewController+UIPickerViewDelegate.swift
    
    // this delegate method is used to create custom rows fpr pickerView
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        
//        // Here, we are returning a view
//        
//        // width is equivalent to width of pickerView
//        let customView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 44))
//        
//        // Added an image to the view
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 24, height: 24))
//        imageView.image = codeModel.items[row].image // Set your image
//        customView.addSubview(imageView)
//        
//        // Added a label to the text view
//        let label = UILabel(frame: CGRect(x: 40, y: 0, width: customView.bounds.width - 40, height: 44))
//        label.text = codeModel.items[row].label // Set your text
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 16)
//        customView.addSubview(label)
//        
//        return customView
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
      
        
        // selectedItem.text = codeModel.items[row].label
        selectedItemImg.image = codeModel.items[0].image
        selectedItemImg.image = codeModel.items[row].image
        
        
        
        // selectedItemImg.image = codeModel.items[row].image
    }
}

