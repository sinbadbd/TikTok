//
//  RootVC.swift
//  TikTok
//
//  Created by Imran on 27/6/21.
//

import UIKit
 

class RootVC: UIViewController {
    var isNavBack = false
    var isTopbar = false
    var isTLogo = true
    var topbarTitle = ""
    let scrollView = UIScrollView(),
    topBarView = UIView(),
    topView = UIView(),
    containerView = UIView(),
    statusBarView = UIView(),
    logoView = UIImageView(),
    titleLbl = UILabel()
    var contentView = UIView()
    var statusBarHeight:NSLayoutConstraint?,
    topBarHeight:NSLayoutConstraint?,
    topViewHeight:NSLayoutConstraint?,
    bottomViewHeight:NSLayoutConstraint?,
    transparentButton : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        clearExistingSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        transparentButton?.removeFromSuperview()
        transparentButton = nil
    }
    
    func setUpNavBar() {
        if isNavBack{
            detectNavigationBackAction()
        }
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
//        navController.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func  clearExistingSetting(){
//        for aView in navController.view.subviews {
//            if aView.tag == 999 {
//                aView.isHidden = true
//                print("AView Status: \(aView)")
//            }
//        }
        //actionButton?.floatButton?.isHidden = true
    }
    
    func setupUI() {
        
        self.view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(statusBarView)
        
        
        statusBarHeight = statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height)
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarHeight!.isActive = true
        
        topBarView.clipsToBounds = true
        self.view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        
        topBarHeight = topBarView.heightAnchor.constraint(equalToConstant: 40)
        topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBarView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topBarView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        topBarHeight!.isActive = true
        
        self.view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topViewHeight = topView.heightAnchor.constraint(equalToConstant: 0)
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        //topView.backgroundColor = .red
        topViewHeight!.isActive = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        scrollView.addConstraints([
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
        
        setupTopbar()
        resetBase()
        /*
         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
         //self.contentHeight!.constant = 5000
         self.resetBase()
         
         }
         */
        
    }
    
    func removeScrollview(){
        scrollView.removeFromSuperview()
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        self.view.addConstraints([
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
   
    func resetBase() {
        titleLbl.text = topbarTitle
        if !isTopbar {
            topBarHeight!.constant = 0
        }else{
            topBarHeight!.constant = 40
        }
        if isTLogo {
            setTLogo()
        }
        self.view.layoutIfNeeded()
        
    }
    
    func setContentHeight(height:CGFloat) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
                contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupTopbar() {
        titleLbl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: topBarHeight!.constant)
        titleLbl.textColor = .blue
        titleLbl.font = UIFont(name: "", size: 22)
        titleLbl.textAlignment = .center
        topBarView.addSubview(titleLbl)

//        let imgSz = CGSize(width: 15,  height: 15)
//        let backButton = getButtonWithImage(frame: CGRect(x: 0, y: 0, width: 45, height:titleLbl.frame.size.height), imgName: "iosBack.png", imgSz: CGSize(width: imgSz.width, height: imgSz.height), imgClr: hexToUIColor(hex: "#007AD0"))
//        backButton.addTarget(self, action: #selector(topBtnPressed), for: .touchUpInside)
//        topBarView.addSubview(backButton)

    }
    
    func setTLogo() {
        let aview = UIView(frame: self.view.bounds)
        self.view.insertSubview(aview, at: 0)
        let background = UIImage(named: "newFill1Copy.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: self.view.frame.width-self.view.frame.width*0.7, y: 0, width: self.view.frame.width*0.7, height: self.view.frame.width*0.7))
        imageView.image = background
        imageView.contentMode =  .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        aview.insertSubview(imageView, at: 1)
    }
    
    func detectNavigationBackAction(){
        isNavBack = true
        if transparentButton == nil {
            transparentButton = UIButton()
            transparentButton?.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
                   transparentButton?.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
                   navigationController!.navigationBar.addSubview(transparentButton!)
        }
        
    }
    
    @objc func backAction(sender:UIButton) {
        // Some sction
    transparentButton?.removeFromSuperview()
    transparentButton = nil
    }
    
    @objc func topBtnPressed(sender:UIButton) {
        UIView.animate(withDuration: TimeInterval(0.1), delay: 0.0, options: [], animations: {
            sender.alpha = 0.5
        }) { finished in
            sender.alpha = 1.0
            sender.isEnabled = false
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
}
