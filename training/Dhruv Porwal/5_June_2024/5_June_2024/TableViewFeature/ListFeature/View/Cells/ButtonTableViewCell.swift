import UIKit

protocol ButtonTableViewCellDelegate: AnyObject {
    func didTapButton()
}

/// Here we have created a Custom cell
class ButtonTableViewCell: UITableViewCell {
    weak var delegate: ButtonTableViewCellDelegate?
    
    private let button: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Login Form", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = contentView.bounds
    }
    
    func setupUI() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20.0
        self.backgroundColor = .green
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapButton()
    }
}

