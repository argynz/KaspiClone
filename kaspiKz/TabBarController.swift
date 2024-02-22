import UIKit
import SwiftUI
import ShopScreen
import TransferScreen
import ProfileScreen
import NetworkManager

class TabBarController: UITabBarController {
    var observer: Any?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = .red
        UINavigationBar.appearance().tintColor = .red
        setupTabs(memesResult: nil, productsResult: nil)
        selectedIndex = 2
        
        observer = NotificationCenter.default.addObserver(forName: .didChangeTabBarVisibility, 
                                                          object: nil, queue: .main) { [weak self] notification in
            if let isTabBarHidden = notification.object as? Bool {
                self?.tabBar.isHidden = isTabBarHidden
            }
        }
    }
    
    private func setupTabs(memesResult: Result<[Meme], Error>?, productsResult: Result<[Product], Error>?) {
        let mainPageView = MainPageView(memesResult: memesResult, productsResult: productsResult)
        let main = createNavBar(with: "Главная",
                                and: UIImage(systemName: "house"),
                                viewC: UIHostingController(
                                    rootView: mainPageView))
        let transfer = createNavBar(with: "Переводы",
                                    and: UIImage(systemName: "repeat"),
                                    viewC: HistoryViewController())
        let profile = createNavBar(with: "Профиль",
                                   and: UIImage(systemName: "person.circle"),
                                   viewC: ProfileViewController())
        setViewControllers([main, transfer, profile], animated: false)
    }
    
    private func createNavBar(with title: String, 
                              and image: UIImage?,
                              viewC: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewC)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    func updateMainPageView(memesResult: Result<[Meme], Error>?, productsResult: Result<[Product], Error>?) {
            if let mainNavController = viewControllers?[0] as? UINavigationController,
               let hostingController = mainNavController.viewControllers.first as? UIHostingController<MainPageView> {
                hostingController.rootView = MainPageView(memesResult: memesResult, productsResult: productsResult)
                hostingController.view.setNeedsDisplay()
            }
        }
}
