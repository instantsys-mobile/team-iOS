import UIKit

protocol EntryScreenViewControllerDelegate: AnyObject {
    func didTapNext()
}

class EntryScreenViewController: UIViewController { // Developer

    weak var delegate: EntryScreenViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapNext(_ sender: UIButton) {
        delegate?.didTapNext()
    }
}

