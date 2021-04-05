//
//  CommnentsView.swift
//  TikTok
//
//  Created by Imran on 30/3/21.
//

import UIKit
 

//extension NSAttributedString {
//    func getPlainString() -> String? {
//        var plainString = string
//        var base = 0
//
//        enumerateAttribute(
//            .attachment,
//            in: NSRange(location: 0, length: length),
//            options: [],
//            using: { value, range, stop in
//                if value != nil && (value is EmojiTextAttachment) {
//                    if let subRange = Range<String.Index>(NSRange(location: range.location + base, length: range.length), in: plainString) { plainString.replaceSubrange(subRange, with: (value as? EmojiTextAttachment)?.emojiTag ?? "") }
//                    base += ((value as? EmojiTextAttachment)?.emojiTag.length ?? 0) - 1
//                }
//            })
//
//        return plainString
//    }
//}

class CommnentsView: UIView, UITextViewDelegate {
    
    let contentView = UIView()
    let mainView = UIView()
    
    
    let tableView : UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
    
    let commentBottomView = UIView()
    let fullWindowView = UIView()
    
    let bottomTextView = UITextView()
    
    
    let commentsIcon = ["😀","😂","😍","😝","😘","😎","😢","🥶"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainView)
        mainView.fitToSuper()
        mainView.backgroundColor =  UIColor.init(white: 0, alpha: 0.5)
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
//        mainView.isUserInteractionEnabled = true
//        mainView.addGestureRecognizer(tapGestureRecognizer)
        
 
        
        mainView.addSubview(contentView)
        contentView.position( left: mainView.leadingAnchor, bottom: mainView.bottomAnchor, right: mainView.trailingAnchor)
        contentView.size(height:450)
        //       contentView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle   = .none
        
        
        contentView.roundCorners([ .topLeft, .topRight], radius: 16)
        
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.reuseIdentifier)
        
        tableView.fitToSuper()
        
        bottomTextView.delegate = self
        
        bottomTextView.backgroundColor = .white
        bottomTextView.text = "Add comment..."
        bottomTextView.textColor = UIColor.lightGray
        contentView.addSubview(commentBottomView)
        
        
        commentBottomView.position( left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
        commentBottomView.size(height:80)
        commentBottomView.backgroundColor = .white
        
        let border = UIView()
        commentBottomView.addSubview(border)
        border.position(top: commentBottomView.topAnchor, left: commentBottomView.leadingAnchor, right: commentBottomView.trailingAnchor)
        border.size(height:1)
        border.backgroundColor = UIColor.systemGray
        
        
        commentBottomView.addSubview(bottomTextView)
        bottomTextView.position( left: commentBottomView.leadingAnchor,insets: .init(top: 0, left: 10, bottom: 10, right: 10))
        bottomTextView.size(height:30)
        bottomTextView.backgroundColor = .brown
        bottomTextView.inputAccessoryView = commentBottomView
        
        
        bottomTextView.delegate = self
        
        
        let HStavkView = UIStackView()
        HStavkView.axis = .horizontal
        HStavkView.distribution = .fillEqually
        HStavkView.alignment = .center
        
        commentBottomView.addSubview(HStavkView)
        HStavkView.position( top:commentBottomView.topAnchor ,left: bottomTextView.trailingAnchor, right: commentBottomView.trailingAnchor, insets: .init(top: 5, left: 5, bottom: 5, right: 10))
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
        commentBottomView.addSubview(emojiBottomView)
        emojiBottomView.position(  left: commentBottomView.leadingAnchor, bottom: commentBottomView.bottomAnchor,  right: commentBottomView.trailingAnchor,insets: .init(top: 5, left: 10, bottom: 5, right: 10))
//        emojiBottomView.backgroundColor = .red
        emojiBottomView.size(  height: 30)
        
 
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
        
        
//        data = commentsIcon[sender]
//        bottomTextView.attributedText = true
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
    
    override var canBecomeFirstResponder: Bool {
            return false
        }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
 
        mainView.addSubview(fullWindowView)
        fullWindowView.fitToSuper()
        fullWindowView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeCommentBox(tapGestureRecognizer:)))
        fullWindowView.isUserInteractionEnabled = true
        fullWindowView.addGestureRecognizer(tapGestureRecognizer)
        bottomTextView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if bottomTextView.text.isEmpty {
            bottomTextView.text = nil
            bottomTextView.textColor = UIColor.lightGray
        }
    }
    
    @objc func removeCommentBox(tapGestureRecognizer: UITapGestureRecognizer){
//        removeFromSuperview()
//        bottomTextView.inputAccessoryView =  nil
        bottomTextView.reloadInputViews()
        fullWindowView.backgroundColor = UIColor.clear
    }
    
    @objc func closeViewTapped(){
//        removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CommnentsView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.reuseIdentifier, for: indexPath) as!  CommentsTableViewCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.tableView.frame.width,
                                              height: 50))
        let title = UILabel()
        headerView.addSubview(title)
        title.centerInSuper()
        title.text = "200 Comments"
        
        let  closeButton = TikTokButton( setImage: "delete.left", tintColor: .black)
        headerView.addSubview(closeButton)
        closeButton.position( right: headerView.trailingAnchor, insets: .init(top: 5, left: 0, bottom: 0, right: 10))
        closeButton.centerYInSuper()
        closeButton.size(width:30,height: 24)
        closeButton.addTarget(self, action: #selector(closeViewTapped), for: .touchUpInside)
        
        headerView.backgroundColor = .orange
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //   self.layoutSubviews()
    }
}

