import UIKit
import CoreData
import TransferScreen

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions
                            launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    public func application(_ application: UIApplication, configurationForConnecting 
                            connectingSceneSession: UISceneSession, 
                            options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
