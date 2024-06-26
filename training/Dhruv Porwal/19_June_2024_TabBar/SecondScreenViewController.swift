import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        navigationItem.title = "Second Screen"
        
        // Button to move backwards
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateBack))
        navigationItem.leftBarButtonItem = backButton
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
