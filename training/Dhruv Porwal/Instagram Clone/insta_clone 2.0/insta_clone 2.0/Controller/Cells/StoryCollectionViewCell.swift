import Foundation
import UIKit

// MARK: - StoryCollectionViewCellDelegate
protocol StoryCollectionViewCellDelegateProtocol: AnyObject {
    func didTapAddButton(at indexPath: IndexPath)
    func didTapOnStoryCell(at indexPath: IndexPath)
}

// MARK: - StoryCollectionViewCellClass
class StoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "StoryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = UIImage(systemName: "person.circle") // Replace with your desired image
        return imageView    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: StoryCollectionViewCellDelegateProtocol?
    private var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(addButton)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = frame.height / 2
        
        // Add tap gesture recognizer to contentView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.bounds.height / 2
        imageView.frame = contentView.bounds
        addButton.frame = CGRect(x: contentView.bounds.width - 30, y: contentView.bounds.height - 30, width: 24, height: 24)
    }
    
    @objc private func addButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapAddButton(at: indexPath)
    }
    
    @objc private func handleTapGesture() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapOnStoryCell(at: indexPath)
    }
    
    func configure(with story: Story, showAddButton: Bool, indexPath: IndexPath) {
        self.indexPath = indexPath
        if let image = UIImage(named: story.imageName) {
            imageView.image = image
        } else {
            print("Failed to load image: \(story.imageName)")
        }
        addButton.isHidden = !showAddButton
    }
}

