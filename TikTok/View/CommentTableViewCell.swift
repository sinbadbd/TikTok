//
//  CommentTableViewCell.swift
//  TikTok
//
//  Created by Imran on 30/3/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CommentTableViewCell"
    
    let profileImage = UIImageView()
    let commentsLabel = UILabel()
    
//    var VStack = UIStackView()
    var likeButton = TikTokButton()
    
    
    var VStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 5
        return stackview
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI(){
        addSubview(profileImage)
        profileImage.position(top: topAnchor, left: leadingAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 0))
        profileImage.size(width:40,height: 40)
        profileImage.layer.cornerRadius = 20
        profileImage.backgroundColor = .red
        
        addSubview(commentsLabel)
        commentsLabel.position(top: topAnchor, left: profileImage.trailingAnchor, bottom: bottomAnchor , insets: .init(top: 10, left: 10, bottom: 10, right: 0))
//        commentsLabel.backgroundColor = .blue
        commentsLabel.text = "hahahahahahahahahahahahahahahdfsfsdfsfsffdff"
        commentsLabel.numberOfLines = 0
        commentsLabel.size(width:280)
        
        addSubview(VStack)
        VStack.position(top: topAnchor, left: commentsLabel.trailingAnchor, right: trailingAnchor, insets: .init(top: 10, left: 5, bottom: 0, right: 10))
        VStack.size(width:40)
//        VStack.backgroundColor = .red
        
        likeButton = TikTokButton(setImage: "heart.fill",tintColor: UIColor.gray)
        likeButton.size(width:34,height: 30)
        likeButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        likeButton.clipsToBounds = true
        likeButton.tag = 1
 
        let likeLabel = TikTokLabel( text: "112 K", textColor: UIColor.red, fontSize: UIFont.systemFont(ofSize: 14), textAlign: .center)
        likeLabel.size(height:10)
        
        VStack.addArrangedSubview(likeButton)
        VStack.addArrangedSubview(likeLabel)
        
       // VStack = UIStackView(arrangedSubviews: [likeButton,likeLabel], axis: .vertical, spacing: 2, alignment: .center, distribution: .fillEqually)
        
    }
    
    @objc func buttonPressed(){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
