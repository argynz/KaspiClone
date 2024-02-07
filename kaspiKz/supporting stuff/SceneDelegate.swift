//
//  SceneDelegate.swift
//  kaspiKz
//
//  Created by Argyn on 02.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let networkingManager = NetworkingManagerImpl()
        //NetworkingManager:
//        init() {
//            madeRequestShopPage()
//        }
        //
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

