//
//  HomeCollectionViewCell.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit
import Lottie

var nav = UINavigationController()


protocol HomeFeedButtonClickDeleget:AnyObject {
    func profileButtonPressed()
    func likeButtonPressed()
    func commentButtonTapped()
    func shareButtonTapped()
}


//@available(iOS 13.0, *)
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
        stackview.spacing = 20
        return stackview
    }()
    
    
    let profileView     = UIImageView()
    var likeButton      = TikTokButton()
    var commentButton   = TikTokButton()
    var shareButton     = TikTokButton()
    let userProfileView = UIImageView()
    
    let leftContentView = UIView()
    
    var userName = TikTokLabel()
    var commentLabel = TikTokLabel()
    
    weak var delegate : HomeFeedButtonClickDeleget!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    func setupUI(){
        addSubview(vedioLinkView)
        vedioLinkView.fitToSuper()
        addSubview(VStackView)
        
        vedioLinkView.backgroundColor = .darkGray
        
        var bottomPadding:CGFloat = 0
        
        if UIDevice.current.hasNotch {
            //... consider notch
            bottomPadding = 110
        } else {
            //... don't have to consider notch
            bottomPadding = 80
        }
        
        addSubview(leftContentView)
        leftContentView.position( left: leadingAnchor, bottom: bottomAnchor, right: VStackView.trailingAnchor,insets: .init(top: 0, left: 20, bottom: bottomPadding, right: 90))
        leftContentView.size(width: 200)
        leftContentView.backgroundColor = .red
        
        let name = "@Imr4nTheM4ad#$sdfsdfs"
        let str = "sfsdfsdfsdfsdfsdfsdfsdfsdfsfsdfsdfsdfsdfsfs"
        let hashTag = "#tiktok #game #more #ios #android"
        userName = TikTokLabel(text: "\(name)\n\n\(str)\n\(hashTag)", textColor: .white, fontSize: UIFont.boldSystemFont(ofSize: 12), textAlign: .left)
        leftContentView.addSubview(userName)
        
        
        userName.position( left: leftContentView.leadingAnchor,bottom: leftContentView.bottomAnchor,right: leftContentView.trailingAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        
        let soundTack = TikTokLabel( text: "Sound Tack(game of the month)", textColor: .white, fontSize: UIFont.boldSystemFont(ofSize: 10), textAlign: .left)
        leftContentView.addSubview(soundTack)
        
        UIView.animateKeyframes(withDuration: 10, delay: 0, options: .repeat, animations: {
            soundTack.center.x += self.leftContentView.bounds.width
            
        }, completion: nil)
        
        
        VStackView.position( bottom:  bottomAnchor, right:  trailingAnchor, insets: .init(top: 0, left: 0, bottom: bottomPadding, right: 20))
        
        
        
        profileView.size(width:60,height: 60)
        profileView.layer.cornerRadius = 30
        profileView.clipsToBounds = true
        profileView.layer.masksToBounds = true
        profileView.image = UIImage(named: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(tapGestureRecognizer)
        
        
        let btn = TikTokButton(setImage: "plus.circle.fill",tintColor: UIColor.red)
        //        let btn = TikTokButton(setImage: UIImage(named: "person.crop.circle.fill"), tintColor: UIColor.white)
        profileView.addSubview(btn)
        btn.position(bottom: profileView.bottomAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0  ))
        btn.centerXInSuper()
        btn.size(width:24, height: 24)
        
        
        
        
        likeButton = TikTokButton(setImage: "heart.fill",tintColor: UIColor.white)
        likeButton.size(width:34,height: 30)
        likeButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        likeButton.clipsToBounds = true
        likeButton.tag = 1
        
        let likeLabel = TikTokLabel( text: "112 K", textColor: UIColor.white, fontSize: UIFont.systemFont(ofSize: 14), textAlign: .center)
        likeLabel.size(height:10)
        
        
        
        let VStackLikeView = UIStackView(
            arrangedSubviews: [likeButton,likeLabel],
            axis: .vertical, spacing: 5,
            alignment: .center,
            distribution: .fill
        )
        //MARK: COMMENT
        
        
        commentButton = TikTokButton(setImage: "bubble.left.fill",tintColor: UIColor.white)
        commentButton.size(width:34,height: 30)
        commentButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        commentButton.clipsToBounds = true
        commentButton.tag = 2
        
        let commentLabel = TikTokLabel( text: "20 K", textColor: UIColor.white, fontSize: UIFont.systemFont(ofSize: 14), textAlign: .center)
        commentLabel.size(height:10)
        
        
        let VStackCommentiew = UIStackView(arrangedSubviews: [commentButton,commentLabel]
                                           , axis: .vertical, spacing: 5, alignment: .center, distribution: .fill)
        
        
        shareButton = TikTokButton(setImage: "arrowshape.turn.up.right.fill",tintColor: UIColor.white)
        shareButton.size(width:34,height: 30)
        shareButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        shareButton.clipsToBounds = true
        shareButton.tag = 3
        
        let shareLabel = TikTokLabel( text: "20", textColor: UIColor.white, fontSize: UIFont.systemFont(ofSize: 14), textAlign: .center)
        shareLabel.size(height:10)
        
        
        let VStackShareView = UIStackView(arrangedSubviews: [shareButton,commentLabel]
                                          , axis: .vertical, spacing: 5, alignment: .center, distribution: .fill)
        
        
        userProfileView.size(width:60,height: 60)
        userProfileView.backgroundColor = .magenta
        userProfileView.image = UIImage(named: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate)
        userProfileView.layer.cornerRadius = 30
        userProfileView.layer.borderWidth = 10
        userProfileView.layer.borderColor = UIColor.black.cgColor
        
        
        
        
        VStackView.addArrangedSubview(profileView)
        
        VStackView.addArrangedSubview(VStackLikeView)
        VStackView.addArrangedSubview(VStackCommentiew)
        
        VStackView.addArrangedSubview(VStackShareView)
        VStackView.addArrangedSubview(userProfileView)
        
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Profile vc")
        delegate.profileButtonPressed()
    }
    
    @objc func buttonPressed(_ sender: UIButton){
        
        if sender.tag == 1 {
            print("Like button")
            delegate.likeButtonPressed()
        }else if sender.tag == 2 {
            print("comment button")
            delegate.commentButtonTapped()
            
        }else if sender.tag == 3 {
            print("share button")
            delegate.shareButtonTapped()
        }
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
