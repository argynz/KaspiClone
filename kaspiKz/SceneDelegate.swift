import UIKit
import SwiftUI
import NetworkManager
import ShopScreen

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let networkManager = NetworkManagerImpl()
    
    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = TabBarController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        self.window = window
        self.window?.makeKeyAndVisible()
        
        networkManager.fetchMainPageData { productsResult, memesResult in
            DispatchQueue.main.async {
                tabBarController.updateMainPageView(memesResult: memesResult, productsResult: productsResult)
            }
        }
    }
}
