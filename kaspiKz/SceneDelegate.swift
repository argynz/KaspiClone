import UIKit
import SwiftUI
import NetworkManager
import ShopScreen

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let mainViewModel = MainPageViewModel()
    let networkManager = NetworkManagerImpl()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        networkFetch()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController(mainPageViewModel: mainViewModel)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func networkFetch(){
        networkManager.fetchMemes{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMemes):
                    self?.mainViewModel.memes = fetchedMemes
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        networkManager.fetchProducts{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedProducts):
                    self?.mainViewModel.products = fetchedProducts
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

