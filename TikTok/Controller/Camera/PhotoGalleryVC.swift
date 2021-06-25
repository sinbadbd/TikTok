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
    
    var  gallerySelectedView: GalleryBottomView?
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
                            bottom: 45,
                            right: 0)
        )
        //        tabView?.fitToSuper()
        tabView?.menuItems = items
        tabView?.tabName = selectedItem.count > 0 ? selectedItem : items[0]
        tabView?.setupUI()
        
        
        gallerySelectedView =  GalleryBottomView()
        view.addSubview(gallerySelectedView!)
        gallerySelectedView?.position(
                          left: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          right: view.trailingAnchor,
                          insets: .init(
                            top: 0,
                            left: 0,
                            bottom: 0,
                            right: 0)
        )
//        gallerySelectedView?.size(height:100)

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
   
    }
 
    func setTabView(tabContentView: TabContentView){
        for subView in tabContentView.subviews {
            subView.removeFromSuperview()
        }
        let tabName = items[tabContentView.tag]
        print(tabName)
        
        if tabName == StarPointHistoryTab.video.rawValue {
            
            let videoView = VideoView()
            videoView.delegate = self
            tabContentView.addSubview(videoView)
            videoView.position(top: tabContentView.topAnchor, left: tabContentView.leadingAnchor, bottom: tabContentView.bottomAnchor)
            videoView.size(dimensionWidth:tabContentView.widthAnchor, dimensionHeight: tabContentView.heightAnchor)
        
            videoView.tabName = "Video"
        }
        
        else if tabName ==  StarPointHistoryTab.photos.rawValue {
            
            let photoView = PhotosView()
            tabContentView.addSubview(photoView)
            photoView.position(top: tabContentView.topAnchor, left: tabContentView.leadingAnchor, bottom: tabContentView.bottomAnchor)
            photoView.size(dimensionWidth:tabContentView.widthAnchor, dimensionHeight: tabContentView.heightAnchor)
 
             photoView.tabName = "Photo"
            
        }
    }
    
    @objc func handleClosebtn(){
        dismiss(animated: true, completion: nil)
    }
    
 
    
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

extension PhotoGalleryVC: PhotoSelectedDelegate{
    func selectGallery(index: Int) {
        print(index)
        if index > 0 {
//            self.gallerySelectedView?.removeFromSuperview()
            self.gallerySelectedView?.nextBtn.isEnabled = true
            self.gallerySelectedView?.nextBtn.backgroundColor = .systemRed
            self.gallerySelectedView?.layoutIfNeeded()
            
            //MARK:- COLLECTION VIEW
            self.gallerySelectedView?.collectionView.isHidden = false
            self.gallerySelectedView?.collectionView.size(height:90)
            
            
        }
    }
    
    
}
