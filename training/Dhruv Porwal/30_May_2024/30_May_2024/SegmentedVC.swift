import UIKit

class SegmentedVC: UIViewController {
    @IBOutlet weak var container2Outlet: UIView!
    @IBOutlet weak var containerOutlet: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up segmented control
        segmentController.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Show containerOutlet view
            self.view.bringSubviewToFront(containerOutlet)
        case 1:
            // Show container2Outlet view
            self.view.bringSubviewToFront(container2Outlet)
        default:
            break
        }
    }
}

