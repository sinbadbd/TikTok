//
//  CameraTopView.swift
//  TikTok
//
//  Created by Imran on 5/4/21.
//

import UIKit
class CameraTopView: UIView {
    
    let addSoundView     = UIView()
    
    let closeBtn :  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        //button.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        alpha = 0.6
        layer.cornerRadius = 4
        
        addSubview(addSoundView)
        addSoundView.position(top: topAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        addSoundView.size(width: 120, height: 40)
        addSoundView.centerXInSuper()
        addSoundView.backgroundColor = .init(white: 0, alpha: 0.3)
        addSoundView.layer.cornerRadius = 8
        
        let iconSound = UIImageView(image: UIImage(named: "music.note"))
        addSoundView.addSubview(iconSound)
        iconSound.position(left: addSoundView.leadingAnchor,insets: .init(top: 0, left: 10, bottom: 0, right: 0))
        iconSound.size(width:20, height: 20)
        iconSound.backgroundColor = .red
        iconSound.centerYInSuper()
        
        let addSoundTitle = UILabel()
        addSoundView.addSubview(addSoundTitle)
        addSoundTitle.position(left: iconSound.leadingAnchor,insets: .init(top: 0, left: 30, bottom: 0, right: 0))
        addSoundTitle.centerYInSuper()
        addSoundTitle.text = "Add Sound"
        addSoundTitle.font = .systemFont(ofSize: 12)
        addSoundTitle.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
