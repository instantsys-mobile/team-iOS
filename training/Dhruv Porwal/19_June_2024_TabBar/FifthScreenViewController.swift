import UIKit

class FifthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Fifth Screen"
        
        // Create instances of the view controllers
        let firstViewController = FirstViewController2()
        let secondViewController = SecondViewController2()
        let thirdViewController = ThirdViewController2()
        let fourthViewController = FourthViewController2()
        let fifthViewController = FifthViewController2()
        
        // Create an instance of UITabBarController
        let tabBarController = UITabBarController()
        
        // Wrap each view controller in a navigation controller
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        let secondNavController = UINavigationController(rootViewController: secondViewController)
        let thirdNavController = UINavigationController(rootViewController: thirdViewController)
        let fourthNavController = UINavigationController(rootViewController: fourthViewController)
        let fifthNavController = UINavigationController(rootViewController: fifthViewController)
        
        // Configure tab bar items for each view controller
        firstNavController.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "star"), tag: 0)
        secondNavController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "star"), tag: 1)
        thirdNavController.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "star"), tag: 2)
        fourthNavController.tabBarItem = UITabBarItem(title: "Fourth", image: UIImage(systemName: "star"), tag: 3)
        fifthNavController.tabBarItem = UITabBarItem(title: "Fifth", image: UIImage(systemName: "star"), tag: 4)
        
        // Set the view controllers for the tab bar controller
        tabBarController.viewControllers = [firstNavController, secondNavController, thirdNavController, fourthNavController, fifthNavController]
        
        // Set the tab bar controller as the root view controller
        self.view.window?.rootViewController = tabBarController
    }
}

import UIKit

class FirstViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "First Screen"
    }
}

class SecondViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "First Screen"
    }
}

class ThirdViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "First Screen"
    }
}

class FourthViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "First Screen"
    }
}

class FifthViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "First Screen"
    }
}
