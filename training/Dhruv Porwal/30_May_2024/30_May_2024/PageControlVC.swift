import UIKit

class PageControlVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentViewControllerIndex: Int = 0
    var childVCs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate and add child view controllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifiers = [ "AutoLayoutVC", "PickerVC", "LoginPageVC", "SegmentedVC"]
        for identifier in identifiers {
            if let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? UIViewController {
                addChild(viewController)
                containerView.addSubview(viewController.view)
                viewController.view.frame = containerView.bounds
                viewController.didMove(toParent: self)
                childVCs.append(viewController)
            }
        }
        
        // Here, we initialized the properties of pageControl
        pageControl.numberOfPages = childVCs.count
        pageControl.currentPage = currentViewControllerIndex
    }
    
    @IBAction func prevButton(_ sender: Any) {
        showViewController(at: currentViewControllerIndex - 1)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        showViewController(at: currentViewControllerIndex + 1)
    }
    
    func showViewController(at index: Int) {
        guard index >= 0 && index < childVCs.count else {
            return
        }
        
        let previousViewController = childVCs[currentViewControllerIndex]
        let nextViewController = childVCs[index]
        
        // Remove previous view controller
        previousViewController.willMove(toParent: nil)
        previousViewController.view.removeFromSuperview()
        previousViewController.removeFromParent()
        
        // Add next view controller
        addChild(nextViewController)
        containerView.addSubview(nextViewController.view)
        nextViewController.view.frame = containerView.bounds
        nextViewController.didMove(toParent: self)
        
        currentViewControllerIndex = index
        pageControl.currentPage = currentViewControllerIndex
    }
}

