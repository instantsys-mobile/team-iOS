import UIKit

class SixthScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "6th Screen"

        // Add a "Back" button to dismiss this view controller
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissScreen))
    }

    @objc func dismissScreen() {
        // Dismiss this view controller to return to the previous view controller
        dismiss(animated: true, completion: nil)
    }
}

