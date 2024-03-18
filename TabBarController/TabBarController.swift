import UIKit

class TabBarController: UITabBarController {
    private let tabBarModel = TabBarModel()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAndTabBars()
    }
    
    // MARK: View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Setup TabBar and NavigationBar
    private func setupNavigationAndTabBars() {
        var navigationControllers = [UINavigationController]()
        let controllers = [MapViewController(), FriendsViewController(), ProfileViewController()]
        
        for (index, controller) in controllers.enumerated() {
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.tabBarItem = UITabBarItem(title: tabBarModel.titles[index],
                                                           image: UIImage(systemName: tabBarModel.imageNames[index]),
                                                           selectedImage: nil)
            
            navigationController.navigationBar.prefersLargeTitles = true
            navigationControllers.append(navigationController)
        }
        setViewControllers(navigationControllers, animated: true)
    }
    
}
