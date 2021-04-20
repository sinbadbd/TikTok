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
//    var captionTextView = UITextView()
//    var placeholderLabel =  UILabel()
//    var coverImgView = UIImageView()
    
    var  vedioPostHeaderView : VedioPostHeaderView?
    let bottomView = UIView()
    
    var postBtn = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup
    func setupView(){
        let dismissKeybordGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeybordGesture)
        
        
        vedioPostHeaderView = VedioPostHeaderView()
        view.addSubview(vedioPostHeaderView!)
        vedioPostHeaderView?.position(top: view.topAnchor, left: view.leadingAnchor,right: view.trailingAnchor,insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        vedioPostHeaderView?.size(height:150)
 
        view.addSubview(bottomView)
        bottomView.position(left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor)
        bottomView.size(height:100)
        bottomView.backgroundColor = .gray
        
        
        bottomView.addSubview(postBtn)
        postBtn.position( bottom: bottomView.bottomAnchor, right: bottomView.trailingAnchor, insets: .init(top: 0, left: 0, bottom: 20, right: 20))
        let postGesture = UITapGestureRecognizer(target: self, action: #selector(publishPost))
        postBtn.addGestureRecognizer(postGesture)
        postBtn.size(width:100,height: 40)
        postBtn.backgroundColor = .systemRed
        let lbl = UILabel()
        postBtn.addSubview(lbl)
        lbl.text = "POST"
        lbl.position(insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        lbl.fitToSuper()
        
    }
 
    @objc func dismissKeyboard(){
        vedioPostHeaderView?.captionTextView.endEditing(true)
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
// MARK: SwiftUI Preview
#if DEBUG
struct ContentViewControllerContainerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ContentViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        return VedioPostVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewControllerContainerView().colorScheme(.light) // or .dark
    }
}
#endif
