//
//  VedioPostVC.swift
//  TikTok
//
//  Created by Imran on 5/4/21.
//

import UIKit
import SnapKit
import SwiftUI

@available(iOS 13.0, *)
class VedioPostVC: UIViewController {
    
    // MARK: - Variables
    var videoURL: URL?
    
    // MARK: - UI Components
    
    var  vedioPostHeaderView : VedioPostHeaderView?
    let bottomView = UIView()
    
    var postBtn = UIView()
    var draftBtn = UIView()
    
    let VStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        return stackview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    /*
     override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     navigationController?.setNavigationBarHidden(false, animated: animated)
     }
     
     override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     navigationController?.setNavigationBarHidden(true, animated: animated)
     }*/
    
    // MARK: - Setup
    func setupView(){
        let dismissKeybordGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeybordGesture)
        
        
        vedioPostHeaderView = VedioPostHeaderView()
        view.addSubview(vedioPostHeaderView!)
        vedioPostHeaderView?.position(
            top: view.topAnchor,
            left: view.leadingAnchor,
            right: view.trailingAnchor,
            insets: .init(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0)
        )
        vedioPostHeaderView?.size(height:150)
        vedioPostHeaderView?.videoURL = videoURL
        
        view.addSubview(bottomView)
        bottomView.position(
            left: view.leadingAnchor,
            bottom: view.bottomAnchor,
            right: view.trailingAnchor
        )
        bottomView.size(height:100)
        //        bottomView.backgroundColor = .red
        
        bottomView.addSubview(VStackView)
        
        VStackView.position(
            left: bottomView.leadingAnchor,
            bottom: bottomView.bottomAnchor,
            right: bottomView.trailingAnchor,
            insets: .init(
                top: 0,
                left: 20,
                bottom: 20,
                right: 20)
        )
        let postGesture = UITapGestureRecognizer(target: self, action: #selector(publishPost))
        postBtn.addGestureRecognizer(postGesture)
        postBtn.size( height: 50)
        postBtn.backgroundColor = .systemRed
        postBtn.layer.cornerRadius = 2
        let lbl = UILabel()
        postBtn.addSubview(lbl)
        lbl.text = "Post"
        lbl.textColor = .white
        lbl.centerYInSuper()
        lbl.centerXInSuper()
        
        let draftBtnGesture = UITapGestureRecognizer(target: self, action: #selector(draftBtnPublishPost))
        draftBtn.addGestureRecognizer(draftBtnGesture)
        draftBtn.size(height: 50)
        draftBtn.layer.cornerRadius = 2
        draftBtn.layer.borderWidth = 1
        draftBtn.layer.borderColor = UIColor.lightGray.cgColor
        let lblx = UILabel()
        draftBtn.addSubview(lblx)
        lblx.text = "Drafts"
        lblx.centerXInSuper()
        lblx.centerYInSuper()
        lblx.textColor = .black
        
        
        VStackView.addArrangedSubviews([draftBtn,postBtn])
    }
    
    @objc func dismissKeyboard(){
        vedioPostHeaderView?.captionTextView.endEditing(true)
    }
    
    @objc func draftBtnPublishPost(){
        print("haha")
    }
    @objc func publishPost(){
        // Disable the buttion to prevent duplicate posts
        postBtn.isUserInteractionEnabled = false
        if let url = videoURL {
            let caption = vedioPostHeaderView?.captionTextView.text ?? ""
            MediaViewModel.shared.postVideo(videoURL: url, caption: caption, success: { message in
                print(message)
                self.postBtn.isUserInteractionEnabled = true
                self.dismiss(animated: true, completion: nil)
            }, failure: { error in
                self.showAlert(error.localizedDescription)
            })
        }
    }
    
    
}
