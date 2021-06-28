//
//  ProfileVC.swift
//  TikTok
//
//  Created by Imran on 5/4/21.
//

import UIKit

class ProfileVC: RootVC {
    
    private let userProfile : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let userName : UILabel = {
        let lbl = UILabel()
        lbl.text = "@sinbad"
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    private lazy var followingButton : UIButton  = {
        let btn = UIButton()
        btn.titleLabel?.numberOfLines = 2
        
        let title = NSMutableAttributedString()
        
        let likeCount = getAttributedText(string: "20\n", font: UIFont.boldSystemFont(ofSize: 14), color: .black, lineSpace: 2, alignment: .center)
        let following = getAttributedText(string: "Following", font: UIFont.systemFont(ofSize: 12), color: .gray, lineSpace: 2, alignment: .center)
        
        title.append(likeCount)
        title.append(following)
        btn.setAttributedTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var followersButton : UIButton  = {
        let btn = UIButton()
        btn.titleLabel?.numberOfLines = 2
        
        let title = NSMutableAttributedString()
        
        //        let paragraphStyle = NSMutableParagraphStyle()
        let likeCount = getAttributedText(string: "110\n", font: UIFont.boldSystemFont(ofSize: 14), color: .black, lineSpace: 2, alignment: .center)
        let following = getAttributedText(string: "Followers", font: UIFont.systemFont(ofSize: 12), color: .gray, lineSpace: 2, alignment: .center)
        
        title.append(likeCount)
        title.append(following)
        btn.setAttributedTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return btn
    }()

    
    private lazy var LikeButton : UIButton  = {
        let btn = UIButton()
        btn.titleLabel?.numberOfLines = 2
        
        let title = NSMutableAttributedString()
        
        let likeCount = getAttributedText(string: "10\n", font: UIFont.boldSystemFont(ofSize: 14), color: .black, lineSpace: 2, alignment: .center)
        let following = getAttributedText(string: "Like", font: UIFont.systemFont(ofSize: 12), color: .gray, lineSpace: 2, alignment: .center)
        
        title.append(likeCount)
        title.append(following)
        btn.setAttributedTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var editProfileButton : UIButton  = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var favoritesButton : UIButton  = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plus.circle.fill"), for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return btn
    }()
    
    
    var profileSlideBarView : ProfileSlideBarView?
//    var menuBar: MenuBarView?
    var borderTop : BroderView?
    var  borderBottom : BroderView?
    
    var menuBar : MenuBarView = {
        let menubar = MenuBarView()
        return menubar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupVC()
        
        setupProfileUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        menuBar.firstItemSelected()
    }
    
    //MARK:-
    func setupVC(){
        topViewHeight?.constant = navController.navigationBar.frame.size.height
        resetBase()
    }
    func setupProfileUI(){
        
        contentView.addSubview(userProfile)
        userProfile.position(top: contentView.topAnchor,insets: .init(top: 40, left: 0, bottom: 0, right: 0))
        userProfile.centerXInSuper()
        userProfile.size(width:100,height: 100)
        userProfile.layer.cornerRadius = 50
        userProfile.backgroundColor = .red
        
        contentView.addSubview(userName)
        userName.position(top: userProfile.bottomAnchor,insets: .init(top: 10, left: 0, bottom: 0, right: 0))
        userName.centerXInSuper()
        
        let stackView = UIStackView()
        
        contentView.addSubview(stackView)
        stackView.position(top: userName.bottomAnchor,insets: .init(top: 10, left: 0, bottom: 0, right: 0))
        stackView.centerXInSuper()
        
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.axis = .horizontal
        
        
        stackView.addArrangedSubview(followingButton)
        stackView.addArrangedSubview(followersButton)
        stackView.addArrangedSubview(LikeButton)
        
        contentView.addSubview(editProfileButton)
        editProfileButton.position(top: stackView.bottomAnchor,insets: .init(top: 10, left: 0, bottom: 0, right: 0))
        editProfileButton.centerXInSuper()
        editProfileButton.size(width:150,height: 35)
        
        contentView.addSubview(favoritesButton)
        favoritesButton.position(top:stackView.bottomAnchor, left: editProfileButton.trailingAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 0))
        favoritesButton.size(width:40,height: 35)
        
        // MARK:- BORDER
        borderTop = BroderView()
        contentView.addSubview(borderTop!)
        borderTop?.position(top: editProfileButton.bottomAnchor, left: contentView.leadingAnchor,  right: contentView.trailingAnchor, insets: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        
        menuBar = MenuBarView()
        contentView.addSubview(menuBar)
        menuBar.position(top: borderTop?.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 10))
        menuBar.size(height:30)
        menuBar.tabCout = 3
        menuBar.backgroundColor = .red
        
        // MARK:- BORDER
        borderBottom = BroderView()
        contentView.addSubview(borderBottom!)
        borderBottom?.position(top: menuBar.bottomAnchor, left: contentView.leadingAnchor, bottom:contentView.bottomAnchor , right: contentView.trailingAnchor, insets: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    
    @objc func  btnTapped(){
        print("hii")
    }
}
