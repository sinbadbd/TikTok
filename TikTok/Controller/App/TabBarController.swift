//
//  TabbarController.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/8/20.
//  Copyright © 2020 Kaishan. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class TabBarController:  UITabBarController, UITabBarControllerDelegate {
    
    var homeNavigationController        : BaseNavigationController!
    var homeViewController              : HomeFeedVC!//VedioPostVC!//HomeFeedVC!
    var discoverViewController          : DiscoverViewController!
    var mediaViewController             : CameraPreviewVC!//MediaViewController!
    var inboxViewController             : InboxViewController!
    var profileViewController           : ProfileVC! //ProfileViewController!//ProfileVC! //ProfileViewController!
    var searchViewController           : SearchViewController!
    
    /*
     MARK:- RND CAMERA
     
     - CameraViewController!
     - DemoFilterCamVC
     - RnD2CameraVC
     */
    
    var cameraFilerVC                   : CameraViewController!
    var cameraRNDFViewVC                : DemoFilterCamVC!
    //    var rnD2CameraVC                    : RnD2CameraVC!
    
    var recordViewController            : RecordViewController! //MARK::
    
    //MARK: - LifeCycles
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        //        tabBar.barTintColor = .black
        //        tabBar.isTranslucent = false
        //        tabBar.unselectedItemTintColor = .gray
        //        tabBar.tintColor = .white
        
        homeViewController          = HomeFeedVC()//HomeFeedVC()//VedioPostVC()//HomeFeedVC()
        homeNavigationController    = BaseNavigationController(rootViewController: homeViewController)
        discoverViewController      = DiscoverViewController()
        mediaViewController         = CameraPreviewVC()//MediaViewController() //MARK:- MY design vc
        inboxViewController         = InboxViewController()
        profileViewController       = ProfileVC()//ProfileViewController() //ProfileVC() //ProfileViewController()
        searchViewController        = SearchViewController()
        cameraFilerVC               = CameraViewController()
        cameraRNDFViewVC            = DemoFilterCamVC()
        //        rnD2CameraVC                = RnD2CameraVC()
        
        recordViewController = RecordViewController()
        homeViewController.tabBarItem.image = UIImage(named: "house")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "house.fill")
        
        searchViewController.tabBarItem.image = UIImage(named: "magnifyingglass.circle.png")
        searchViewController.tabBarItem.selectedImage = UIImage(named: "magnifyingglass.circle.fill.png")
        
        mediaViewController.tabBarItem.image = UIImage(named: "plus (3)")?.withRenderingMode(.alwaysOriginal)
        
        inboxViewController.tabBarItem.image = UIImage(named: "text.bubble")
        inboxViewController.tabBarItem.selectedImage = UIImage(named: "text.bubble.fill")
        
        profileViewController.tabBarItem.image = UIImage(named: "person.crop.circle")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "person.crop.circle.fill")
        
        viewControllers = [homeViewController, searchViewController, mediaViewController, inboxViewController, profileViewController]
        
        let tabBarItemTitle = ["Home", "Discover", "Add", "Inbox", "Me"]
        
        
        for (index, tabBarItem) in tabBar.items!.enumerated() {
            tabBarItem.title = tabBarItemTitle[index]
            if index == 1 {
                let tabBar = UITabBar.appearance()
                tabBar.barTintColor = UIColor.clear
                tabBar.backgroundImage = UIImage()
                tabBar.shadowImage = UIImage()
                
            }
            else if index == 2 {
                // Media Button
                tabBarItem.title = ""
                tabBarItem.imageInsets = UIEdgeInsets(top: -6, left: 0, bottom: -6, right: 0)
                
            }
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: CameraPreviewVC.self) {
            
            let vc = CameraPreviewVC()//CameraPreviewVC()
            let navigationController = BaseNavigationController.init(rootViewController: vc)
            //            navigationController.modalPresentationStyle = .overFullScreen
            self.present(navigationController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
}
