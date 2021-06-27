//
//  BottomInputView.swift
//  TikTok
//
//  Created by Imran on 27/6/21.
//

import UIKit

class BottomCommentInputView: UIView, UITextViewDelegate {

    
    let backgroundView = UIView()
    let containerView = UIView()
    let bottomTextView = UITextView()

    
    let commentsIcon = ["😀","😂","😍","😝","😘","😎","😢","🥶"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBottomInputView()
    }
    // MARK: - Display Animations
    @objc func show(){
        // Add CommentPopUpView in the front of the current window
        //        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        //          let sceneDelegate = windowScene.delegate as? SceneDelegate
        //        else {
        //          return
        //        }
        //        sceneDelegate.window?.addSubview(self)
        
        
        let window = UIApplication.shared.keyWindow!
        //                self.commentsView = CommnentsView()
        window.addSubview(self)
        //                commentsView?.centerXInSuper()
        //                commentsView?.fitToSuper(
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
            self.frame.origin.y = 0
        }) { finished in
            
        }
    }
    
    func setupBottomInputView(){
//        let window = UIApplication.shared.keyWindow!
//        //                self.commentsView = CommnentsView()
//        window.addSubview(backgroundView)
        
        addSubview(backgroundView)
        backgroundView.fitToSuper()
//        backgroundView.backgroundColor = .whitde
 
        
        backgroundView.addSubview(containerView)
        containerView.position( left: backgroundView.leadingAnchor, bottom:  backgroundView.bottomAnchor, right:  backgroundView.trailingAnchor, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
        containerView.size(height:100)
        
        let border = UIView()
        containerView.addSubview(border)
        border.position(top: containerView.topAnchor, left: containerView.leadingAnchor, right: containerView.trailingAnchor)
        border.size(height:1)
        border.backgroundColor = UIColor.systemGray
        
        
        containerView.addSubview(bottomTextView)
        bottomTextView.position( left: containerView.leadingAnchor,insets: .init(top: 0, left: 10, bottom: 10, right: 10))
        bottomTextView.size(height:30)
        bottomTextView.backgroundColor = .brown
        bottomTextView.inputAccessoryView = backgroundView
        
        
        bottomTextView.delegate = self
        
        
        let HStavkView = UIStackView()
        HStavkView.axis = .horizontal
        HStavkView.distribution = .fillEqually
        HStavkView.alignment = .center
        
        containerView.addSubview(HStavkView)
        HStavkView.position( top:containerView.topAnchor ,left: bottomTextView.trailingAnchor, right: containerView.trailingAnchor, insets: .init(top: 5, left: 5, bottom: 5, right: 10))
        HStavkView.size(width:80)
//        HStavkView.centerYInSuper()
        
        
        
        let hashTagBtn = TikTokButton(setTitle: "@", textColor: .black, setImage: nil)
        hashTagBtn.size(width:20,height: 20)
        hashTagBtn.tag = CommnetItemButton.hastagBtn.rawValue
        hashTagBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        
        let emojiBtn = TikTokButton(setTitle: "@", textColor: .black, setImage: nil)
        emojiBtn.size(width:20,height: 20)
        emojiBtn.tag = CommnetItemButton.emojiBtn.rawValue
        emojiBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        
        let addQuesBtn = TikTokButton(setTitle: "@", textColor: .black, setImage: nil)
        addQuesBtn.size(width:20,height: 20)
        addQuesBtn.tag = CommnetItemButton.askBtn.rawValue
        addQuesBtn.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        
        
        HStavkView.addArrangedSubviews([hashTagBtn,emojiBtn,addQuesBtn])
        
        
        let emojiBottomView = UIView()
        containerView.addSubview(emojiBottomView)
        emojiBottomView.position(  left: containerView.leadingAnchor, bottom: containerView.bottomAnchor,  right: containerView.trailingAnchor,insets: .init(top: 5, left: 10, bottom: 5, right: 10))
//        emojiBottomView.backgroundColor = .red
        emojiBottomView.size(  height: 0)
        emojiBottomView.isHidden = true
 
        var xPos = 2
            for (emoji, index) in commentsIcon.enumerated() {
              
              //  let emo = commentsIcon[emoji]
                print(emoji, index)
                let emojiButton = UIButton()
                emojiButton.frame = CGRect(x: xPos, y: 0, width: 50, height: 30)
                emojiButton.setTitle("\(index)", for: .normal)
                emojiButton.setTitleColor(UIColor.black, for: .normal)
                emojiButton.tag = emoji
                emojiButton.addTarget(self, action: #selector(handleEmojiButton), for: .touchUpInside)
//                emojiButton.f
                emojiBottomView.addSubview(emojiButton)
                xPos += 50
            }
    }
    
    
    @objc func handleEmojiButton(sender : UIButton){
           print(sender.tag)
        var data = [String]()
 
        bottomTextView.text = commentsIcon[sender.tag]
       }
    
    
    @objc func tapBtnTapped(_ sender:UIButton){
        
        if sender.tag == CommnetItemButton.hastagBtn.rawValue {
            print(sender.tag)
        } else if sender.tag == CommnetItemButton.emojiBtn.rawValue {
            print(sender.tag)
        } else if sender.tag == CommnetItemButton.askBtn.rawValue {
            print(sender.tag)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
