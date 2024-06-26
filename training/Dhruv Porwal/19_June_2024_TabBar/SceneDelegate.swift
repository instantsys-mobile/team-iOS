import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // var entryScreenViewControllerDelegate = EntryScreenViewController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a UIWindow
        window = UIWindow(windowScene: windowScene)
        
        // Setted up EntryScreenViewController as the initial view controller
        let entryViewController = EntryScreenViewController()
        entryViewController.delegate = self 
        // Assigned delegate for transition and using delegate method to transfer the data
        
        window?.rootViewController = entryViewController
        window?.makeKeyAndVisible()
    }
}

// MARK: - EntryScreenViewControllerDelegate
extension SceneDelegate: EntryScreenViewControllerDelegate {
    
    func didTapNext() {
        // Instantiating the UITabBarController where we are
        let tabBarController = UITabBarController()
        
        // Creating the  SecondViewController, ThirdViewController, and FourthiewController
        let secondViewController = SecondViewController()
        let thirdViewController = ThirdViewController()
        let fourthViewController = FourthViewController()
        
        // Wrapping each view controller in a UINavigationController so that they can themselves act like stacks of VC hierarchy
        
        let navigationController1 = UINavigationController(rootViewController: secondViewController)
        let navigationController2 = UINavigationController(rootViewController: thirdViewController)
        let navigationController3 = UINavigationController(rootViewController: fourthViewController)
        
        navigationController1.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "star"), selectedImage: nil)
        navigationController2.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "person"), selectedImage: nil)
        navigationController3.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "heart"), selectedImage: nil)
        
        tabBarController.viewControllers = [navigationController1, navigationController2, navigationController3]
        
        // Setting tab bar controller as root view controller
        window?.rootViewController = tabBarController
    }
}

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }




