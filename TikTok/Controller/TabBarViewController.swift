//
//  TabBarViewController.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit

@available(iOS 13.0, *)
class TabBarViewController: UITabBarController {
    
    var mTabBar: UITabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeFeedVC()
        let vc2 = SearchViewController()
        let vc3 = UIViewController()
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        
        nav1.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav1.navigationBar.prefersLargeTitles = true
        
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        nav2.navigationBar.prefersLargeTitles = true
        
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "building.columns"), selectedImage: UIImage(systemName: "building.columns.fill"))
        nav3.navigationBar.prefersLargeTitles = true
        
        
        setViewControllers([nav1,nav2,nav3], animated: true)
        
        
        self.navigationController?.isNavigationBarHidden = true
        view.insetsLayoutMarginsFromSafeArea = false
  
//        UITabBar.appearance().barTintColor = UIColor(red: 0, green:0, blue: 0, alpha: 0)
//        self.tabBarController?.tabBar.isTranslucent = true

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
 

}
