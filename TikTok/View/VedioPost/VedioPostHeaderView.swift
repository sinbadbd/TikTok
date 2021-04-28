//
//  VedioPostHeader.swift
//  TikTok
//
//  Created by Imran on 6/4/21.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
class VedioPostHeaderView: UIView,UITextViewDelegate {
    
    var videoURL: URL?
    var playerView: MediaPlayerView?
    
    
    var captionTextView : UITextView = {
        let captionView = UITextView()
        return captionView
    }()
    private var placeholderLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var coverImgView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    private var pictureView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private let hashTagBtn : UIButton = {
        let button = UIButton()
        button.setTitle("#HashTags", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = .init(gray: 0.5, alpha: 1)
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let friendBtn : UIButton = {
        let button = UIButton()
        button.setTitle("@Friends", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = .init(gray: 0.5, alpha: 1)
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 4
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let captionViewWithPicture = UIView()
        addSubview(captionViewWithPicture)
        captionViewWithPicture.position(top: topAnchor, left: leadingAnchor,right: trailingAnchor,insets: .init(top: 10, left: 10, bottom: 0, right: 10))
        captionViewWithPicture.size(height:150)
        
        captionViewWithPicture.addSubview(captionTextView)
        captionTextView.position(
            top: captionViewWithPicture.topAnchor,
            left: captionViewWithPicture.leadingAnchor,
            insets: .init(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0)
            )
        captionTextView.size(
            width:230,
            height: 100
        )
        captionTextView.delegate = self
//        captionTextView.backgroundColor = .red
        captionTextView.text = "Add description..."
        placeholderLabel = UILabel()
        captionTextView.addSubview(placeholderLabel)
        
        captionViewWithPicture.addSubview(hashTagBtn)
        
        hashTagBtn.position(
            left: captionViewWithPicture.leadingAnchor,
            bottom:captionViewWithPicture.bottomAnchor ,
                            insets: .init(
                                top: 0,
                                left: 0,
                                bottom: 10,
                                right: 0
                            )
        )
        hashTagBtn.size(width:80,height: 30)
        
        captionViewWithPicture.addSubview(friendBtn)
        friendBtn.position(
            left: hashTagBtn.trailingAnchor,
            bottom:captionViewWithPicture.bottomAnchor ,
                            insets: .init(
                                top: 0,
                                left: 10,
                                bottom: 10,
                                right: 0
                            )
        )
        friendBtn.size(width:80,height: 30)
        
        
        captionViewWithPicture.addSubview(pictureView)
        pictureView.backgroundColor = .green
        
        pictureView.position(
            top: captionViewWithPicture.topAnchor,
            left: captionTextView.trailingAnchor,
            bottom: captionViewWithPicture.bottomAnchor,
            right: captionViewWithPicture.trailingAnchor,
            insets: .init(
                top: 0,
                left: 10,
                bottom: 0,
                right: 0)
        )
        pictureView.layer.cornerRadius = 4
        let tapView = UITapGestureRecognizer(target: self, action: #selector(tapVedioView))
        pictureView.addGestureRecognizer(tapView)
        pictureView.isUserInteractionEnabled =  true

        presentPlayerView() //MARK: VIDEO
        
        
        
        let borderbottom = UIView()
        addSubview(borderbottom)
        borderbottom.position(
            top: captionViewWithPicture.bottomAnchor,
            insets: .init(
                top: 10,
                left: 0,
                bottom: 0,
                right: 0)
        )
        borderbottom.size(height: 1, dimensionWidth:  widthAnchor)
        borderbottom.backgroundColor = .lightGray
        
    }
    
    func presentPlayerView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            if let url = videoURL {
                playerView = MediaPlayerView(frame:  pictureView.frame, videoURL: url)
                pictureView.addSubview(playerView!)
                playerView?.fitToSuper()
                 
                let selectCoverLbl = UILabel()
                playerView?.addSubview(selectCoverLbl)
                selectCoverLbl.position( bottom: playerView?.bottomAnchor, insets: .init(top: 0, left: 10, bottom: 5, right: 10))
                selectCoverLbl.centerXInSuper()
                selectCoverLbl.text = "Select Cover"
                selectCoverLbl.textColor = .white
                selectCoverLbl.font = UIFont.systemFont(ofSize: 12)
            }
        }
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if captionTextView.text == "Add description..." {
            captionTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if captionTextView.text == "" {
            captionTextView.text = "Add description..."
            captionTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
    @objc func tapVedioView(){
        let window = UIApplication.shared.keyWindow!
        let fullScreenView = FullScreenVedioView()
        
        
        
        window.addSubview(fullScreenView)
        fullScreenView.fitToSuper()
        fullScreenView.videoURL = videoURL
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

