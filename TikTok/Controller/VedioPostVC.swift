//
//  VedioPostVC.swift
//  TikTok
//
//  Created by Imran on 5/4/21.
//

import UIKit

@available(iOS 13.0, *)
class VedioPostVC: UIViewController,UITextViewDelegate {
    
    // MARK: - Variables
    var videoURL: URL?
    
    
    
    // MARK: - UI Components
    var captionTextView = UITextView()
    var placeholderLabel =  UILabel()
    var coverImgView = UIImageView()
    
    
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
        
        // Add placeholder
//        captionTextView =
        view.addSubview(captionTextView)
        captionTextView.position(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, insets: .init(top: 30, left: 10, bottom: 0, right: 20))
        captionTextView.size(height:200)
        captionTextView.delegate = self
        captionTextView.backgroundColor = .red
        //        placeholderLabel = UILabel()
        //        placeholderLabel.text = "Describe your video"
        //        placeholderLabel.font = UIFont.systemFont(ofSize: (captionTextView.font?.pointSize)!)
        //        placeholderLabel.sizeToFit()
        //        captionTextView.addSubview(placeholderLabel)
        //        placeholderLabel.frame.origin = CGPoint(x: 5, y: (captionTextView.font?.pointSize)! / 2)
        //        placeholderLabel.textColor = UIColor.lightGray
        //        placeholderLabel.isHidden = !captionTextView.text.isEmpty
        
        
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
//        postBtn.s
    }
    
    @objc func dismissKeyboard(){
        captionTextView.endEditing(true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    @objc func publishPost(){
        // Disable the buttion to prevent duplicate posts
        postBtn.isUserInteractionEnabled = false
        if let url = videoURL {
            let caption = captionTextView.text ?? ""
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
