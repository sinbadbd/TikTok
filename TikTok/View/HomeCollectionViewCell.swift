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
@available(iOS 13.0, *)
class HomeCollectionViewCell: UICollectionViewCell {
    static let identify = "HomeCollectionViewCell"
    
    var playerView: VideoPlayerView?
    
    
    
    //    let vedioLinkView : UIView = {
    //        let vedio = UIView()
    //        return vedio
    //    }()
    
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
    let  pauseImgView = UIImageView()
    var userName = TikTokLabel()
    var commentLabel = TikTokLabel()
    
    weak var delegate : HomeFeedButtonClickDeleget!
    
    // MARK: - Variables
    private(set) var isPlaying = false
    private(set) var liked = false
    var post: Post?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    // MARK: LIfecycles
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView?.cancelAllLoadingRequest()
        resetViewsForReuse()
    }
    
    
    func setupUI(){
        
        playerView = VideoPlayerView()
        addSubview(playerView!)
        playerView?.fitToSuper()
        
        addSubview(VStackView)
        
        //        vedioLinkView.backgroundColor = .darkGray
        
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
        
     
        addSubview(pauseImgView)
        pauseImgView.centerXInSuper()
        pauseImgView.size(width:50, height: 50)
    }
    func configure(post: Post){
        self.post = post
        
        
        likeButton.setTitle(post.likeCount.shorten(), for: .normal)
        shareButton.setTitle(post.shareCount.shorten(), for: .normal)
        
        let name = "@ \(post.autherName)"
        let str = "\(post.music + "   " + post.music + "   " + post.music + "   ")"
        let hashTag = "\(post.caption)"
        userName = TikTokLabel(text: "\(name)\n\n\(str)\n\(hashTag)", textColor: .white, fontSize: UIFont.boldSystemFont(ofSize: 12), textAlign: .left)
        
        
        playerView?.configure(url: post.videoURL, fileExtension: post.videoFileExtension, size: (post.videoWidth, post.videoHeight))
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Profile vc")
        delegate.profileButtonPressed()
    }
    
    @objc func buttonPressed(_ sender: UIButton){
        UIView.animate(withDuration: 0.5) {
            sender.alpha = 0.5
        } completion: { [self] _  in
            sender.alpha = 1
            
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
        
        
    }
    
    func replay(){
        if !isPlaying {
            playerView?.replay()
            play()
        }
    }
    
    func play() {
        if !isPlaying {
            playerView?.play()
            //            musicLbl.holdScrolling = false
            isPlaying = true
        }
    }
    
    func pause(){
        if isPlaying {
            playerView?.pause()
            //            musicLbl.holdScrolling = true
            isPlaying = false
        }
    }
    
    @objc func handlePause(){
                if isPlaying {
                    // Pause video and show pause sign
                    UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                        guard let self = self else { return }
                        self.pauseImgView.alpha = 0.35
                        self.pauseImgView.transform = CGAffineTransform.init(scaleX: 0.45, y: 0.45)
                    }, completion: { [weak self] _ in
                        self?.pause()
                    })
                } else {
                    // Start video and remove pause sign
                    UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                        guard let self = self else { return }
                        self.pauseImgView.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.play()
                        self?.pauseImgView.transform = .identity
                    })
                }
    }
    
    func resetViewsForReuse(){
        likeButton.tintColor = .white
        //        pauseImgView?.alpha = 0
    }
    
    
    // MARK: - Actions
    // Like Video Actions
    @IBAction func like(_ sender: Any) {
        if !liked {
            likeVideo()
        } else {
            liked = false
            likeButton.tintColor = .white
        }
        
    }
    
    @objc func likeVideo(){
        if !liked {
            liked = true
            likeButton.tintColor = .red
        }
    }
    
    // Heart Animation with random angle
    @objc func handleLikeGesture(sender: UITapGestureRecognizer){
        let location = sender.location(in: self)
        let heartView = UIImageView(image: UIImage(named: "heart.fill"))
        heartView.tintColor = .red
        let width : CGFloat = 110
        heartView.contentMode = .scaleAspectFit
        heartView.frame = CGRect(x: location.x - width / 2, y: location.y - width / 2, width: width, height: width)
        heartView.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -CGFloat.pi * 0.2...CGFloat.pi * 0.2))
        self.contentView.addSubview(heartView)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
            heartView.transform = heartView.transform.scaledBy(x: 0.85, y: 0.85)
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
                heartView.transform = heartView.transform.scaledBy(x: 2.3, y: 2.3)
                heartView.alpha = 0
            }, completion: { _ in
                heartView.removeFromSuperview()
            })
        })
        likeVideo()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
