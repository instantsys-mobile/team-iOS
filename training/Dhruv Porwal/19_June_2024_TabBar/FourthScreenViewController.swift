import UIKit

class FourthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Fourth Screen"
        
        // Add a button to push SixthScreenViewController
        let sixthScreenButton = UIButton(type: .system)
        sixthScreenButton.setTitle("Show 6th Screen", for: .normal)
        sixthScreenButton.addTarget(self, action: #selector(pushSixthScreen), for: .touchUpInside)
        view.addSubview(sixthScreenButton)
        
        sixthScreenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sixthScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sixthScreenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func pushSixthScreen() {
        let sixthScreenViewController = SixthScreenViewController()
        let navigationController = UINavigationController(rootViewController: sixthScreenViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
