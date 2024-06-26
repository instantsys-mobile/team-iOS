//
//  MainTabController.swift
//  insta_clone 2.0
//
//  Created by DhruvPorwal on 20/06/24.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
   // MARK :- Properties
    private var user: UserProfile? {
        didSet {
            guard let user = user else {return}
            configureViewControllersForTabBarController(withUser: user)
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        // this method is gonna be called when the view loads in memory in the application, gets called only one time
        super.viewDidLoad()
//        configureViewControllersForTabBarController()
        checkIfUserIsLoggedIn()
        fetchUser() // why are we calling this here? -> our VCs won't get set up until this guy user won't get setted up because we are calling  configureViewControllersForTabBarController(withUser: user) this in didSet up which is better becuase we don't want this to be setted up before the data comes back from server
    }
    // API checkIfUserIsLoggedIn
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.authenticationDelegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            
        }
    }

    // MARK: - API
    func fetchUser() {
        print("Called fetch User")
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    // MARK: - Helpers
    
    func configureViewControllersForTabBarController(withUser user: UserProfile) {
        let layout = UICollectionViewFlowLayout()
        let profile = ProfileController(user: user)
        
        view.backgroundColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        
        // stored instances of these Classes(VIew Controllers in each of these constants
        // let feedSection = FeedController() earlier
        
        // while initializing the collection view, we need to pass the layout type
        let feedSection = templateNavigationController(unselectedImage: UIImage(named:"home_unselected")! , selectedImage: UIImage(named: "home_selected")!, rootViewController: FeedViewController()) // collectionViewLayout: layout
        
//                let searchSection = templateNavigationController(unselectedImage: UIImage(named:"search_unselected")! , selectedImage: UIImage(named: "search_selected")!, rootViewController: SearchController())
        
        //
        //        let imageSelectorSection = templateNavigationController(unselectedImage: UIImage(named:"plus_unselected")! , selectedImage: UIImage(named: "plus_unselected")!, rootViewController: ImageSelectorController())
        //
        //        let notificationsSection = templateNavigationController(unselectedImage: UIImage(named:"like_unselected")! , selectedImage: UIImage(named: "like_selected")!, rootViewController: NotificationsController())
        //
//        let profileSection =  templateNavigationController(unselectedImage: UIImage(named:"profile_unselected")! , selectedImage: UIImage(named: "profile_selected")!, rootViewController: ProfileController(collectionViewLayout: profilelayout))
        
        let profileSection = templateNavigationController(unselectedImage: UIImage(named:"profile_unselected")! , selectedImage: UIImage(named: "profile_selected")!, rootViewController: profile)
        
        viewControllers = [feedSection, // searchSection, // imageSelectorSection, // notificationsSection,
                           profileSection]
    }
    
    // This method is being used to create amazing Views already with VC and tab bar images and nav bar titles
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        nav.navigationBar.backgroundColor = .white
        nav.navigationBar.barTintColor = .white
        // Optionally, if you want the navigation bar to extend under the status bar
        nav.navigationBar.isTranslucent = false
        
        return nav
        
    }
}

extension MainTabController: AuthenticationDelegate {   
    func authenticationDidComplete() {
        print("Auth Did Complete. Fetch user and Update Here")
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
