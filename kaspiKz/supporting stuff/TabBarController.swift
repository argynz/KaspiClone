import UIKit
import SwiftUI
import ShopScreen

class TabBarController: UITabBarController{
    var observer: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = .red
        UINavigationBar.appearance().tintColor = .red
        setupTabs()
        //selectedIndex = 2
        
        observer = NotificationCenter.default.addObserver(forName: .didChangeTabBarVisibility, object: nil, queue: .main) { [weak self] notification in
            if let isTabBarHidden = notification.object as? Bool {
                self?.tabBar.isHidden = isTabBarHidden
            }
        }
    }
    
    private func setupTabs(){
        let main = createNavBar(with: "Главная", and: UIImage(systemName: "house"), vc: UIHostingController(rootView: MainPageView()))
        let transfer = createNavBar(with: "Переводы", and: UIImage(systemName: "repeat"), vc: HistoryViewController())
        let profile = createNavBar(with: "Профиль", and: UIImage(systemName: "person.circle"), vc: ProfileViewController())
        setViewControllers([main, transfer, profile], animated: false)
    }
    
    private func createNavBar(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
}
