import UIKit
import Firebase

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    private var user: UserProfile
    
    private let images: [UIImage] = [
        UIImage(named: "pup")!,
        UIImage(named: "venom")!,
        UIImage(named: "profile_1")!,
        UIImage(named: "skyscraper")!
        
    ]
    
    init(user: UserProfile) {
        self.user = user // dependency injection
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    // MARK: - Properties
    //    var user: UserProfile? {
    //        didSet { // initially value is nil but later on with didSet observer the value is called when the property user is setted in fetchUser fn
    //            collectionView.reloadData()
    //        }
    //    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        configureCollectionView()
    //        // fetchUser() removed to main tab bar now,
    //    }
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count // Number of cells in each section
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileViewCell
        // Configure your cell here if needed
        // Configure cell with corresponding image
        let image = images[indexPath.item]
        cell.configure(with: image) // every time configure being called and different images being set in it
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        //        if let user = user {
        //            header.profileHeaderViewModelObject = ProfileHeaderViewModel(user: user)
        //        }// we no longer need it because now, we are taking it as dependency injection init not a optional
        // earlier we were fetching in profile view controller. Now, we are doing it in main tab bar controller i.e. we are initializing it in main tab bar controller
        
        header.profileHeaderViewModelObject = ProfileHeaderViewModel(user: user)
        
        // Configure your header here if needed
        header.delegate = self // Set the delegate to self
        // Configure your header here if needed
        return header
    }
    
    // we removed fetch user from here now to put it in main tab bar controller and from there we will initialize the profile view controller
    
    
    // MARK: - Actions
    
    
    // MARK: - Private Methods
    
    private func configureCollectionView() {
        navigationItem.title = user.fullname
        collectionView.backgroundColor = .white
        collectionView.register(ProfileViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2) / 3 // Adjust spacing as needed
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // Adjust spacing between items horizontally
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // Adjust spacing between items vertically
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200) // Height of header
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func userDidTapLogout() {
        do {
            try Auth.auth().signOut()
            
            // Navigate to the login screen
            let controller = LoginController()
            // necessary
            controller.authenticationDelegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        } catch {
            print("Failed to log out")
        }
    }
}
