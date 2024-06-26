import UIKit

private let reuseIdentifier = "cell"

class FeedViewController: UIViewController{
    
    
    private var viewModel = FeedViewModel()
    private var storiesCollectionView: UICollectionView!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel.feedViewModelDelegate = self
        viewModel.fetchStories()
        viewModel.createDummyData()
        
        configureNavigationBar()
        tableView.reloadData()
        storiesCollectionView.reloadData()
    }
    
    private func setupViews() {
        
        // we are making use of this function to programmatically set the constraints
        setUpCollectionViewForStories()
        setUpTableView()
        
        view.addSubview(storiesCollectionView)
        view.addSubview(tableView)
        
        // Layout constraints
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Stories Collection View Constraints
            
            storiesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storiesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 90), // Adjust height as needed
            
            // Table View Constraints
            tableView.topAnchor.constraint(equalTo: storiesCollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // Configure navigation bar with title and buttons
    private func configureNavigationBar() {
        let titleView = UILabel()
        titleView.text = "InstaClone"
        titleView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleView.textColor = .black
        titleView.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
        
        let quitButton = UIButton(type: .system)
        quitButton.setTitle("Quit", for: .normal)
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        let quitBarButton = UIBarButtonItem(customView: quitButton)
        navigationItem.rightBarButtonItem = quitBarButton
    }
    
    @objc private func quitButtonTapped() {
        exit(0) // This forcefully exits the application
    }
    
    func setUpCollectionViewForStories() {
        // Create flow layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Set scroll direction to horizontal
        layout.itemSize = CGSize(width: 80, height: 80) // Set item size
        layout.minimumLineSpacing = 10 // Set minimum line spacing between items
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Set section insets
        
        // Creating collection view for stories
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        storiesCollectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        storiesCollectionView.backgroundColor = .white
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        storiesCollectionView.showsHorizontalScrollIndicator = false // Hide horizontal scroll indicator
        storiesCollectionView.alwaysBounceHorizontal = true // Enable horizontal bouncing
        
        // If you want to disable bouncing entirely, you can set:
        // storiesCollectionView.alwaysBounceHorizontal = false
    }
    
    func setUpTableView() {
        // Create table view for feed
        tableView = UITableView()
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private static func createLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 3, bottom: 5, trailing: 3)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(110))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 1
        // For spacing b/w items
        
        return section
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfStories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // This method is used to configure the cell and set the data to it
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as! StoryCollectionViewCell
        
        let story = viewModel.story(at: indexPath.item)
        let showAddButton = indexPath.row == 0 // Show addButton only for the first cell
        cell.configure(with: story, showAddButton: showAddButton, indexPath: indexPath)
        cell.delegate = self // Set delegate to FeedViewController
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped on Story at \(indexPath.row)")
        storiesCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        let post = viewModel.post(at: indexPath.row)
        cell.delegate = self
        cell.configure(with: post, user: post.user, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped on feed Post at \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FeedViewModelProtocol
extension FeedViewController: FeedViewModelDelegateProtocol {
    
    func showCommentViewController(chatViewModel: CommentsViewModel) {
        
        let commentsVC = CommentsViewController(viewModel: chatViewModel)
        commentsVC.modalPresentationStyle = .pageSheet
        //        chatVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        
        // Set up detents for the presentation controller
        if let sheetPresentationController = commentsVC.presentationController as? UISheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
        }
        self.present(commentsVC, animated: true)
    }
    
    func dataUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.storiesCollectionView.reloadData()
        }
    }
}

// MARK: - FeedTableViewCellDelegate
extension FeedViewController: FeedTableViewCellDelegateProtocol {
    
    func didTapProfileImage(at indexPath: IndexPath) {
        print("Profile image tapped at indexPath: \(indexPath)")
    }
    
    func didTapLikeButton(at indexPath: IndexPath) {
        viewModel.toggleLike(at: indexPath.row)
        //        tableView.reloadRows(at: [indexPath], with: .none)
        
        DispatchQueue.main.async {
            // self.tableView.reloadRows(at: [indexPath], with: .none)// main thread serial queue
            self.tableView.reloadData()
        }
    }
    
    func didTapShareButton(at indexPath: IndexPath) {
        print("Share button tapped at indexPath: \(indexPath)")
    }
    
    func didTapCommentButton(at indexPath: IndexPath) {
        viewModel.tapComment(at: indexPath.row)
        print("Comment button tapped at indexPath: \(indexPath)")
    }
}

// MARK: - StoryCollectionViewCellDelegate
extension FeedViewController: StoryCollectionViewCellDelegateProtocol {
    
    func didTapAddButton(at indexPath: IndexPath) {
        let story = viewModel.story(at: indexPath.item)
        print("Tapped on story: \(story.imageName) at \(indexPath.row)")
    }
    
    func didTapOnStoryCell(at indexPath: IndexPath) {
        // Retrieve the story or any necessary data for StoriesViewController
        let story = viewModel.story(at: indexPath.item)
        
        // Instantiate StoriesViewController
        let storiesViewController = StoriesViewController()
        
        // Optionally, pass data to StoriesViewController
        storiesViewController.story = story.imageName
        
        // Hide tab bar when pushing StoriesViewController
        storiesViewController.hidesBottomBarWhenPushed = true
        
        // Check if navigationController is not nil
        guard let navigationController = navigationController else {
            print("Error: navigationController is nil")
            return
        }
        
        if indexPath.row != 0 {
            // Push StoriesViewController onto the navigation stack
            navigationController.pushViewController(storiesViewController, animated: true)
        }  else {
            debugPrint("Can't print your own profile image")
        }
        
    }
}


