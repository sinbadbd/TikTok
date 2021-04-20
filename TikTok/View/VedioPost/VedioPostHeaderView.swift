//
//  VedioPostHeader.swift
//  TikTok
//
//  Created by Imran on 6/4/21.
//

import UIKit

class VedioPostHeaderView: UIView,UITextViewDelegate {
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        let captionViewWithPicture = UIView()
        addSubview(captionViewWithPicture)
        captionViewWithPicture.position(top: topAnchor, left: leadingAnchor,right: trailingAnchor,insets: .init(top: 10, left: 10, bottom: 0, right: 10))
       captionViewWithPicture.size(height:150)
//       captionViewWithPicture.backgroundColor = .blue
        
        
        captionViewWithPicture.addSubview(captionTextView)
        captionTextView.position(top: captionViewWithPicture.topAnchor, left: captionViewWithPicture.leadingAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        captionTextView.size(width:230,height: 100)
        captionTextView.delegate = self
        captionTextView.backgroundColor = .red
        captionTextView.text = "Add description..."
        placeholderLabel = UILabel()
        captionTextView.addSubview(placeholderLabel)
        
        
        let pictureView = UIImageView()
        captionViewWithPicture.addSubview(pictureView)
        //        pictureView.mask
        pictureView.backgroundColor = .green
        pictureView.position(top: captionViewWithPicture.topAnchor, left: captionTextView.trailingAnchor, bottom: captionViewWithPicture.bottomAnchor,right: captionViewWithPicture.trailingAnchor, insets: .init(top: 0, left: 10, bottom: 0, right: 0))
        pictureView.layer.cornerRadius = 4
        //        pictureView.size(height:150)
        
        
        let borderbottom = UIView()
        addSubview(borderbottom)
        borderbottom.position(top: captionViewWithPicture.bottomAnchor,insets: .init(top: 10, left: 0, bottom: 0, right: 0))
        borderbottom.size(height: 1, dimensionWidth:  widthAnchor)
        borderbottom.backgroundColor = .lightGray
    
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if captionTextView.text == "Add description..." {
            captionTextView.text = ""
            captionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if captionTextView.text == "" {
            captionTextView.text = "Add description..."
            captionTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
