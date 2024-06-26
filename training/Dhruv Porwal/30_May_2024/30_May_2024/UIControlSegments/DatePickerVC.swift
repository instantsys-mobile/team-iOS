import UIKit

class DatePickerVC: UIViewController {
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the minimum date for the Date Picker to the current date and time
        datePickerOutlet.minimumDate = Date()
        datePickerOutlet.datePickerMode = .dateAndTime
        datePickerOutlet.preferredDatePickerStyle = .compact
        
        // Here, we have added  target to detect when the value of the Date Picker changes
        datePickerOutlet.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    // Date Picker value change events
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        // Convert the selected date to a string
        let selectedDateTime = dateFormatter.string(from: sender.date)
        
        // Update the label text with the selected date and time
        selectedDateLabel.text = "\(selectedDateTime)"
    }
}

