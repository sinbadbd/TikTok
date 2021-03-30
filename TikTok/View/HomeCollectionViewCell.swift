//
//  HomeCollectionViewCell.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit
import Lottie

@available(iOS 13.0, *)
class HomeCollectionViewCell: UICollectionViewCell {
    static let identify = "HomeCollectionViewCell"
    
    
    let vedioLinkView : UIView = {
        let vedio = UIView()
        return vedio
    }()
    
    let VStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 10
        return stackview
    }()
    
    
    let profileView  = UIImageView()
    var likeButton      = TikTokButton()
    let commentButton   = UIButton()
    let shareButton     = UIButton()
    let userProfileView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    func setupUI(){
        addSubview(vedioLinkView)
        vedioLinkView.fitToSuper()
        vedioLinkView.backgroundColor = .yellow
        
        addSubview(VStackView)
        VStackView.position( bottom:  bottomAnchor, right:  trailingAnchor, insets: .init(top: 0, left: 0, bottom: 80, right: 20))
//        VStackView.size(width:60,height: 350)
        VStackView.backgroundColor = .blue
        
        
        
        profileView.size(width:60,height: 60)
        profileView.backgroundColor = .orange
        profileView.layer.cornerRadius = 30
        profileView.clipsToBounds = true
        profileView.layer.masksToBounds = true
        
        let btn = UIImageView()
        profileView.addSubview(btn)
        btn.image = UIImage(systemName: "plus.circle.fill")
        btn.position(bottom: profileView.bottomAnchor,insets: .init(top: 0, left: 10, bottom: -5, right: 0))
        btn.centerXInSuper()
        btn.size(width:20, height: 20)
        
        
        
        
        
//        let likeView  = UIView()
//        likeView.addSubview(likeButton)
        
        likeButton = TikTokButton(setIcon: "heart.fill",tintColor: UIColor.white)
        likeButton.size(width:40,height: 40)
        likeButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        likeButton.clipsToBounds = true
        
        let likeLabel = UILabel()
        likeLabel.size(height:10)
        likeLabel.text = "Like"
        likeLabel.backgroundColor = .black
        
        
        //MARK: COMMENT
        commentButton.size(width:60,height: 40)
        commentButton.backgroundColor = .gray
        
        
        shareButton.size(width:60,height: 40)
        shareButton.backgroundColor = .cyan
        
        userProfileView.size(width:60,height: 40)
        userProfileView.backgroundColor = .magenta
        
        VStackView.addArrangedSubview(profileView)
        
//        VStackView.addArrangedSubview(likeView)
        
        VStackView.addArrangedSubview(likeButton)
        //        VStackView.addArrangedSubview(likeLabel)
        VStackView.addArrangedSubview(commentButton)
        VStackView.addArrangedSubview(shareButton)
        VStackView.addArrangedSubview(userProfileView)
        
    }
    
    @objc func handleTap(_ sender: UIButton){
        print("hi")
    
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
