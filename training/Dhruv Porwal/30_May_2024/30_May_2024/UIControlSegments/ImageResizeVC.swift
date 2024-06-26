import UIKit

class ImageResizeVC: UIViewController {
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var slider: UISlider!
    
    var imageView = UIImageView()
    var timer: Timer?
    var secsRemain = 0
    var size: CGFloat = 150
    var previousValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.isHidden = true
        // Setting our image to resize
        let customImage = UIImage(named: "small_google_png_icon")
        self.imageView.image = customImage
        self.imageView.frame = CGRect(x: view.bounds.width / 2 - size / 2, y: 10, width: size, height: size)
        self.view.addSubview(imageView)
    }
    
    @IBAction func switchBtna(_ sender: UISwitch) {
        if sender.isOn {
            print("switch is On")
            imageView.isHidden = false
            startAutomaticSliderMovement()
        } else {
            print("switch is OFF")
            stopAutomaticSliderMovement()
        }
    }
    
    func startAutomaticSliderMovement() {
        // Invalidate the timer if it's already running
        timer?.invalidate()
        // Start a timer to increment the slider value periodically
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopAutomaticSliderMovement() {
        // Invalidate the timer to stop the automatic slider movement
        timer?.invalidate()
    }
    
    @objc func updateTimer() {
        if secsRemain > 9 {
            timer?.invalidate()
            print(secsRemain)
            
        } else {
            secsRemain += 1
            let percentageProgress = Float(secsRemain) / 10.0
            updateImageViewSize(value: Double(percentageProgress))
            // Slider mvement stopped right now
            slider.value = percentageProgress
            print(secsRemain)
            stepperOutlet.value = Double(secsRemain)
            secsRemain = Int(slider.value * 10)
        }
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        imageView.isHidden = false
        
        // Update secsRemain before calculating percentageProgress
        secsRemain = Int(sender.value)
        
        // Checking if sender value is less than or equal to 10 (assuming the minimum value of the stepper is 0)
        if sender.value <= 10 {
            print(" + pressed +\(sender.value) + \(stepperOutlet.value)")
            
            // Update UI elements
            let percentageProgress = Float(secsRemain) / 10.0
            slider.value = percentageProgress
            updateImageViewSize(value: Double(percentageProgress))
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        imageView.isHidden = false
        let value = sender.value // Scaling the slider value to match the stepper's range
        secsRemain = Int(value * 10)
        updateImageViewSize(value: Double(value))
        
        stepperOutlet.value = Double(value * 10)
        print(stepperOutlet.value)
    }
    
    func updateImageViewSize(value: Double) {
        imageView.frame = CGRect(x: view.bounds.width / 2 - size * CGFloat(value) / 2,
                                 y: 10,
                                 width: size * CGFloat(value),
                                 height: size * CGFloat(value))
        
    }
    
}

