//
//  HomeCollectionViewCell.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit

public extension UIStackView {
    /// SwifterSwift: Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views (default: 0.0).
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis (default: .fill).
    ///   - distribution: The distribution of the arranged views along the stack view’s axis (default: .fill).
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    /// SwifterSwift: Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    /// SwifterSwift: Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
}


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
        stackview.distribution = .fillProportionally
        stackview.spacing = 10
        return stackview
    }()
    
    
    let profilePicView  = UIView()
    let likeButton      = UIButton()
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
        VStackView.size(width:60,height: 350)
        //        VStackView.backgroundColor = .blue
        
        
        
        profilePicView.size(width:60,height: 40)
        profilePicView.backgroundColor = .yellow
        
        likeButton.size(width:40,height: 40)
        likeButton.backgroundColor = .brown
        likeButton.imageView?.contentMode = .scaleAspectFit
        likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        
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
        
        VStackView.addArrangedSubview(profilePicView)
        VStackView.addArrangedSubview(likeButton)
        VStackView.addArrangedSubview(likeLabel)
        VStackView.addArrangedSubview(commentButton)
        VStackView.addArrangedSubview(shareButton)
        VStackView.addArrangedSubview(userProfileView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
