//
//  AppDelegate.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import UIKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?   // For iOS 12

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
       
//        let vc = HomeFeedVC()
        
        let tabView =  TabBarViewController() //window.rootViewController = TabBarViewController()
    
        let rootVC = UINavigationController(rootViewController: tabView)
//        self.window = UIWindow(windowScene: windowScne)

//        let rootVC = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
//       self.window = window
        
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    // MARK: - UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

   

}
