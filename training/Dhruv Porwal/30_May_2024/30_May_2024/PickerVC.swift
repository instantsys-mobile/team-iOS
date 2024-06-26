import UIKit

class PickerVC: UIViewController {
    
    
    @IBOutlet weak var stopButtonOutlet: UIButton!
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
            progressBar.progress = 0.0
            progressBar.isHidden = true
        }
    }
    
    @IBOutlet weak var progressView: UIActivityIndicatorView! {
        didSet {
            progressView.isHidden = true
        }
    }
    var timer: Timer?
    var isRunning = false
    var secsRemain = 0
    var codeModel = CodeModel()
    var progressValue: Float = 0.0 // Variable to store the current progress value
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func startAction(_ sender: Any) {
        self.isRunning = true
        startButtonOutlet.isHidden = true
        stopButtonOutlet.isHidden = false
        // Show the progress view and start animating
        progressView.isHidden = false
        progressBar.isHidden = false
        progressView.startAnimating()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopAction(_ sender: Any) {
        self.isRunning = false
        self.timer?.invalidate()
        self.timer = nil
        self.secsRemain = 0
        self.progressBar.progress = 0
        progressView.stopAnimating()
        startButtonOutlet.isHidden = false
        stopButtonOutlet.isHidden = true
        print(" stopped ")
    }
    
    
    @objc func updateTimer() {
        if isRunning {
            if self.secsRemain > 10  {
                // self.timer.invalidate()
                self.pickerView.isHidden = false
                self.progressBar.isHidden = true
                self.progressView.isHidden = true
                self.startButtonOutlet.isHidden = true
                self.stopButtonOutlet.isHidden = true
                self.selectedItemImg.isHidden = false
                self.selectedItemImg.image = self.codeModel.items[0].image
            } else {
                self.secsRemain += 1
                let percentageProgress = Float(self.secsRemain) / 10.0
                self.progressBar.progress = percentageProgress
            }
        }
        
    }
    
}

extension PickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return codeModel.items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return codeModel.items[row].label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItemImg.image = codeModel.items[0].image
        selectedItemImg.image = codeModel.items[row].image
    }
}

