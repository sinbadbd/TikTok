//
//  PhotoGalleryVC.swift
//  TikTok
//
//  Created by Imran on 20/6/21.
//

import UIKit

enum StarPointHistoryTab: String {
    case video = "Video"
    case photos = "Photo"
}


class PhotoGalleryVC: UIViewController {
    var items = [String]()
    var selectedItem = ""
    var tabView:TabView?
    
    
    func setUI(){
        
        view.addSubview(closeBtn)
        closeBtn.position(
            top: view.topAnchor,
            left: view.leadingAnchor,
            insets: .init(
                top: 40,
                left: 20,
                bottom: 0,
                right: 0)
        )
        closeBtn.size(width:20,height: 20)
        
        view.addSubview(titleLbl)
        titleLbl.position(
            top: view.topAnchor,
            left: closeBtn.trailingAnchor,
            insets: .init(
                top: 40,
                left: 20,
                bottom: 0,
                right: 0)
        )
        titleLbl.centerXInSuper()
        
        
        
        
        items.append(StarPointHistoryTab.video.rawValue)
        items.append(StarPointHistoryTab.photos.rawValue)
        
        tabView = TabView()
        tabView?.delegate = self
        view.addSubview(tabView!)
        
        tabView?.position(top: closeBtn.bottomAnchor,
                          left: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          right: view.trailingAnchor,
                          insets: .init(
                            top: 20,
                            left: 0,
                            bottom: 0,
                            right: 0)
        )
        //        tabView?.fitToSuper()
        tabView?.menuItems = items
        tabView?.tabName = selectedItem.count > 0 ? selectedItem : items[0]
        tabView?.setupUI()
    }
    
    let closeBtn :  UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(named: "close")?.withTintColor(UIColor.black), for: .normal)
        } else {
            // Fallback on earlier versions
            button.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        button.addTarget(self, action: #selector(handleClosebtn), for: .touchUpInside)
        
        return button
    }()
    
    let titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "All Photos"
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setUI()
        
        
        //        closeBtn.size(width:20,height: 20)
        
        // Do any additional setup after loading the view.
    }
    
    //    func showTab(tab:PackTab){
    //        tabView?.tabName = stringFor(key: tab.rawValue)
    //        tabView?.goToTab()
    //    }
    
    func setTabView(tabContentView: TabContentView){
        for subView in tabContentView.subviews {
            subView.removeFromSuperview()
        }
        let tabName = items[tabContentView.tag]
        print(tabName)
        
        if tabName == StarPointHistoryTab.video.rawValue {
            
            let historyView = VideoView()
            tabContentView.addSubview(historyView)
            historyView.position(top: tabContentView.topAnchor, left: tabContentView.leadingAnchor, bottom: tabContentView.bottomAnchor)
            historyView.size(dimensionWidth:tabContentView.widthAnchor, dimensionHeight: tabContentView.heightAnchor)
            //            historyView.setupUI()
            //            historyView.backgroundColor = .clear
            historyView.tabName = "Video"
        }
        
        else if tabName ==  StarPointHistoryTab.photos.rawValue {
            
            let historyView = PhotosView()
            tabContentView.addSubview(historyView)
            historyView.position(top: tabContentView.topAnchor, left: tabContentView.leadingAnchor, bottom: tabContentView.bottomAnchor)
            historyView.size(dimensionWidth:tabContentView.widthAnchor, dimensionHeight: tabContentView.heightAnchor)
            //            historyView.setupUI()
            //            historyView.backgroundColor = .clear
             historyView.tabName = "Photo"
            
        }
    }
    
    @objc func handleClosebtn(){
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension PhotoGalleryVC: TabViewDelegate {
    func tabPressed(view: TabContentView) {
        self.view.endEditing(true)
        if !view.isLoaded {
            view.isLoaded = true
            setTabView(tabContentView: view)
        }
    }
}
