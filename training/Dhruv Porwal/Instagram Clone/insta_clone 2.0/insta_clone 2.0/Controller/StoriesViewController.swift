import UIKit

class StoriesViewController: UIViewController {
    
    private var panGesture: UIPanGestureRecognizer!
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var story: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Adjust background color as needed
        
        guard let storyPic = story else {
            return
        }
        
        // Created an imageView and set its image on post
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: storyPic)
        view.addSubview(imageView)
        
        
        // Added pan gesture recognizer to detect dragging to feed screen
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: self.view?.window)
        
        if gesture.state == .began {
            initialTouchPoint = touchPoint
        } else if gesture.state == .changed {
            if touchPoint.x - initialTouchPoint.x > 0 {
                self.view.frame = CGRect(x: touchPoint.x - initialTouchPoint.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if gesture.state == .ended || gesture.state == .cancelled {
            if touchPoint.x - initialTouchPoint.x > 100 {
                // If swiped enough, pop the view controller from navigation stack
                navigationController?.popViewController(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }
            }
        }
    }
}
