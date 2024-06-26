
import UIKit

protocol FeedTableViewCellDelegateProtocol: AnyObject {
    func didTapProfileImage(at indexPath: IndexPath)
    func didTapLikeButton(at indexPath: IndexPath)
    func didTapShareButton(at indexPath: IndexPath)
    func didTapCommentButton(at indexPath: IndexPath)
}

class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedTableViewCell"
    weak var delegate: FeedTableViewCellDelegateProtocol?
    private var indexPath: IndexPath?
    private var isLiked = false
    private var posts: [Post] = []
    private var user: User?
    
    private lazy var profileImageView: UIButton = {
        let imageButton = UIButton(type: .custom)
        imageButton.contentMode = .scaleAspectFill
        imageButton.clipsToBounds = true
        imageButton.layer.borderWidth = 2
        imageButton.layer.borderColor = UIColor.clear.cgColor
        
        // Set your desired image
        let image = UIImage(systemName: "person.circle") // Example: Using SF Symbols
        imageButton.setImage(image, for: .normal)
        
        imageButton.addTarget(self, action: #selector(ownerProfileTapped), for: .touchUpInside)
        
        return imageButton
    }()
    
    @objc private func ownerProfileTapped() {
        print("Post Owner Image tapped")
        
        guard let indexPath = self.indexPath else {
            print("IndexPath is nil")
            return
        }
        delegate?.didTapProfileImage(at: indexPath)
    }
    
    let ownerProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = UIImage(systemName: "person.circle") // Replace with your desired image
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var heartButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black // Set tint color to black
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black // Set tint color to black
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .black // Set tint color to black
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var viewAllComments: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal) // Set text color for normal state
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // addAComment
    private lazy var addAComment: UIButton = {
        let button = UIButton()
        button.setTitle("Add a comment...", for: .normal)
        button.setTitleColor(.black, for: .normal) // Set text color for normal state
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(likesLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(viewAllComments)
        contentView.addSubview(addAComment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.frame.size.width - 20
        let buttonSize: CGFloat = 40
        let profileImageSize: CGFloat = 40
        let verticalSpacing: CGFloat = 10 // Adjust the vertical spacing between posts
        
        profileImageView.frame = CGRect(x: 10, y: verticalSpacing, width: profileImageSize, height: profileImageSize)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        
        nameLabel.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.size.width + 10,
                                 y: profileImageView.frame.origin.y,
                                 width: contentView.frame.size.width - profileImageView.frame.origin.x - profileImageView.frame.size.width - 20,
                                 height: 20)
        tagLabel.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.size.width + 5,
                                y: nameLabel.frame.origin.y + nameLabel.frame.size.height,
                                width: contentView.frame.size.width - profileImageView.frame.origin.x - profileImageView.frame.size.width - 20,
                                height: 20)
        
        postImageView.frame = CGRect(x: 10, y: profileImageView.frame.origin.y + profileImageView.frame.size.height + 5, width: imageSize, height: imageSize)
        heartButton.frame = CGRect(x: 10, y: postImageView.frame.origin.y + postImageView.frame.size.height + 10, width: buttonSize, height: buttonSize)
        commentButton.frame = CGRect(x: heartButton.frame.origin.x + heartButton.frame.size.width + 10, y: heartButton.frame.origin.y, width: buttonSize, height: buttonSize)
        shareButton.frame = CGRect(x: commentButton.frame.origin.x + commentButton.frame.size.width + 10, y: heartButton.frame.origin.y, width: buttonSize, height: buttonSize)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [ownerProfileImageView, addAComment])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.alignment = .center
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView = UIStackView(arrangedSubviews: [likesLabel, captionLabel, viewAllComments, horizontalStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.alignment = .leading
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: 5),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalSpacing)
        ])
    }
    
    @objc private func commentButtonTapped() {
        print("Comment Image tapped")
        
        guard let indexPath = self.indexPath else {
            print("IndexPath is nil")
            return
        }
        
        delegate?.didTapCommentButton(at: indexPath)
    }
    
    @objc private func shareButtonTapped() {
        print("Share Button tapped")
        
        guard let indexPath = self.indexPath else {
            print("IndexPath is nil")
            return
        }
        
        delegate?.didTapShareButton(at: indexPath)
    }
    
    @objc private func likeButtonTapped() {
        print("Like Button tapped")
        
        guard let indexPath = self.indexPath else {
            print("IndexPath is nil")
            return
        }
        
        delegate?.didTapLikeButton(at: indexPath)
    }
    
    // Method to get the index path of the parent cell
    private func getParentCellIndexPath() -> IndexPath? {
        if let tableView = superview as? UITableView {
            if let indexPath = tableView.indexPath(for: self) {
                return indexPath
            }
        }
        return nil
    }
    
    public func configure(with post: Post, user: User, indexPath: IndexPath) {
        // Configure the cell with the post data
        self.indexPath = indexPath // Set the indexPath property
        profileImageView.setImage(post.user.profilePhoto, for: .normal)
        nameLabel.text = post.user.username
        tagLabel.text = "@\(post.tag)"
        postImageView.image = post.postImage
        likesLabel.text = "\(post.likes) likes"
        captionLabel.text = String("\(post.user.username): \(post.comments[0].text)")
        viewAllComments.setTitle("View all \(post.comments.count) comments", for: .normal) // Set button title with comment count
        if let index = posts.firstIndex(where: { $0 === post }) {
            // let currentPost = posts[index]
            //            let comments = currentPost.comments
            // Now we have access to the comments associated with this post
        }
        
        
        // Updating UI based on like status
        if post.isLiked {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .systemPink // Set tint color to pink when liked
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .black // Set tint color to black otherwise
        }
        // setupUI() // Call setupUI after user is set
    }
}





