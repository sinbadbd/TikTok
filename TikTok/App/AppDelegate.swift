//
//  AppDelegate.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import UIKit
import Firebase

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?   // For iOS 12

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        
        fireStoreDB()
        
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

    func fireStoreDB(){
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("posts").addDocument(
            data: [
            "userName":"Imr4nTh3M4dG4m3r",
            "description":"This the first awesome app i had created",
            "hashTag":"#ios #android #html #Unity",
            "vedioURL": "Ada",
//            "likeCount": 1232,
//            "ShareCount": 1815,
//            "CommentCount":34234
            
        ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
    }
   

}
