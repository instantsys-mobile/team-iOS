import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        navigationItem.title = "Third Screen"
        
        // Example: Add a button to navigate back to EntryScreenViewController
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateBack))
        navigationItem.leftBarButtonItem = backButton
        
        // Add a button to push FourthViewController
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next Screen", for: .normal)
        nextButton.addTarget(self, action: #selector(pushNextScreen), for: .touchUpInside)
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func pushNextScreen() {
        let fourthViewController = FifthViewController()
        navigationController?.pushViewController(fourthViewController, animated: true)
    }
    
    @objc func navigateBack() {
        // Check if the EntryScreenViewController is still in the navigation stack
        if let entryScreenVC = navigationController?.viewControllers.first(where: { $0 is EntryScreenViewController }) {
            navigationController?.popToViewController(entryScreenVC, animated: true)
        } else {
            // If the EntryScreenViewController is not in the navigation stack,
            // create a new instance and set it as the root view controller
            let entryScreenVC = EntryScreenViewController()
            entryScreenVC.delegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
            let navigationController = UINavigationController(rootViewController: entryScreenVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
    }
}

