import UIKit

class TabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = .red
        UINavigationBar.appearance().tintColor = .red
        setupTabs()
        selectedIndex = 2
    }
    
    private func setupTabs(){
        let main = createNavBar(with: "Главная", and: UIImage(systemName: "house"), vc: ShopViewController())
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
