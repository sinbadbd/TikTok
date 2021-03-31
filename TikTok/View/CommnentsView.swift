//
//  CommnentsView.swift
//  TikTok
//
//  Created by Imran on 30/3/21.
//

import UIKit
protocol CommentInputAccessoryViewDelegate {
    func didSend(for comment: String)
}
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
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        
        tableView.fitToSuper()
        
        bottomTextView.delegate = self
        
        bottomTextView.backgroundColor = .blue
        
        contentView.addSubview(commentBottomView)
        
        commentBottomView.position( left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor)
        commentBottomView.size(height:40)
        commentBottomView.backgroundColor = .red
        
        commentBottomView.addSubview(bottomTextView)
        bottomTextView.position( left: commentBottomView.leadingAnchor, bottom: commentBottomView.bottomAnchor, right: commentBottomView.trailingAnchor,insets: .init(top: 0, left: 20, bottom: 10, right: 20))
        bottomTextView.size(height:30)
        
        bottomTextView.inputAccessoryView = commentBottomView
        
        
        bottomTextView.delegate = self
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.systemPink
        //        print(textView)
        print("\( String(describing: bottomTextView.text) )")
        
        mainView.addSubview(fullWindowView)
        fullWindowView.fitToSuper()
        fullWindowView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeCommentBox(tapGestureRecognizer:)))
        fullWindowView.isUserInteractionEnabled = true
        fullWindowView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.systemTeal
    }
    
    @objc func removeCommentBox(tapGestureRecognizer: UITapGestureRecognizer){
        removeFromSuperview()
        bottomTextView.inputAccessoryView =  nil
        bottomTextView.reloadInputViews()
    }
    
    @objc func closeViewTapped(){
        removeFromSuperview()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as!  CommentTableViewCell
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

