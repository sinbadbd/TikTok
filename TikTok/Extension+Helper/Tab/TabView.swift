//
//  TabView.swift
//  TikTok
//
//  Created by Imran on 20/6/21.
//

import Foundation

import UIKit
protocol TabViewDelegate: AnyObject {
    func tabPressed(view:TabContentView)
}

extension TabViewDelegate {//for optional
    func tabPressed(view:TabContentView){}
}

class TabView: UIView {
    let menuHeight:CGFloat = 36
    weak var delegate : TabViewDelegate?
    var menuBar: BaseScrollView!
    var contentScrollView: BaseScrollView!
    var menuItems:[String] = [String]()
    var tabName = ""
    let btnDefaultColor = hexToUIColor(hex: "#E6E9F4")
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI(){
        if menuItems.count < 1 {
            return;
        }
        if menuBar != nil {
            menuBar.removeFromSuperview()
            menuBar=nil
        }
        if contentScrollView != nil  {
            contentScrollView.removeFromSuperview()
            contentScrollView=nil
        }
        
        menuBar = BaseScrollView()
        menuBar.baseDelegate = self
        //menuBar.backgroundColor = .green
        menuBar.delegate = self
        menuBar.showsHorizontalScrollIndicator = false
        self.addSubview(menuBar)
        menuBar.position(top: topAnchor, left: leadingAnchor, right: trailingAnchor, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        menuBar.size(height:menuHeight)
        
        contentScrollView = BaseScrollView()
        //contentScrollView.backgroundColor = .blue
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.isScrollEnabled = false
        self.addSubview(contentScrollView)
        contentScrollView.position(top: menuBar.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor)
        
        
        var lastBtn:UIView?
        var lastContentView:TabContentView?
        for i in 0..<menuItems.count{
            let title = menuItems[i]
            let barBtn = UIButton(type: .custom)
            barBtn.tag = i
            barBtn.backgroundColor = btnDefaultColor
            barBtn.layer.cornerRadius = menuHeight/2
            barBtn.addTarget(self, action: #selector(itemPressed(sender:)), for: .touchUpInside)
            menuBar.addSubview(barBtn)
            barBtn.position(top: menuBar.topAnchor, left: i == 0 ? menuBar.leadingAnchor : lastBtn?.trailingAnchor, bottom: menuBar.bottomAnchor, right: i == (menuItems.count-1) ? menuBar.trailingAnchor : nil, insets: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
            barBtn.size(height:menuHeight)
            
            let lb = UILabel()
            lb.tag = 11
            lb.textColor = .black
            lb.font = UIFont.init(name: "appFont", size: 12)
            lb.text = title
            barBtn.addSubview(lb)
            //lb.fitToSuper()
            lb.position(top: barBtn.topAnchor, left: barBtn.leadingAnchor, bottom: barBtn.bottomAnchor, right: barBtn.trailingAnchor, insets: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35))
            lastBtn = barBtn
            
            
            //content view
            
            let tabContentView = TabContentView()
            tabContentView.tag = i
            contentScrollView.addSubview(tabContentView)
            tabContentView.position(top: contentScrollView.topAnchor, left: i == 0 ? contentScrollView.leadingAnchor : lastContentView?.trailingAnchor, bottom: contentScrollView.bottomAnchor, right: i == (menuItems.count-1) ? contentScrollView.trailingAnchor : nil, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            //tabContentView.size(width:UIScreen.main.bounds.width, height: 200)
            tabContentView.sizeFrom(view: contentScrollView)
            
            lastContentView = tabContentView
//            if i==2 {
//                tabContentView.backgroundColor = .darkGray
//            }
        }
        
        
        //setNeedsLayout()
        
        
    }
    
    func goToTab(){
        if menuItems.count == 0 {
            return
        }
        if tabName.count < 1 {
            tabName = menuItems[0]
        }
        if !menuItems.contains(tabName)  {
            tabName = menuItems[0]
        }
        let indxOfSelectedTab = menuItems.firstIndex(of: tabName)
        itemSelected(barNo: indxOfSelectedTab!,animated: false)
    }
    
    
    @objc func itemPressed(sender:UIButton) {
        itemSelected(barNo: sender.tag, animated: true)
        
    }
    
    func itemSelected(barNo:Int, animated:Bool) {
        var lastContentView = TabContentView()
        for aView in contentScrollView.subviews {
            if (aView is TabContentView && barNo == aView.tag) {
                let view = aView as! TabContentView
            delegate?.tabPressed(view: view)
                lastContentView = view
                break
            }
        }
        contentScrollView.setContentOffset(CGPoint(x: lastContentView.frame.origin.x, y: 0), animated: animated)
        
        var tabButton:UIButton!
        for aView in menuBar.subviews {
            if aView is UIButton{
                let targetBtn = aView as! UIButton
                targetBtn.backgroundColor = btnDefaultColor
                for subView in targetBtn.subviews {
                    if subView.tag == 11 && subView is UILabel {
                        let targetLbl = subView as! UILabel
                        targetLbl.textColor = .black
                        break
                    }
                }
                if aView.tag == barNo {
                    tabButton = targetBtn
                    targetBtn.backgroundColor = buttonColor
                    for subView in targetBtn.subviews {
                        if subView.tag == 11 && subView is UILabel {
                            let targetLbl = subView as! UILabel
                            targetLbl.textColor = .white
                            break
                        }
                    }
                }

            }
        }
        let menuBarWidth = UIScreen.main.bounds.width
        if (menuBar.contentSize.width > menuBarWidth) {
            var contentOffSetX:CGFloat=(tabButton.frame.origin.x+tabButton.frame.size.width*0.5)-menuBarWidth*0.5
            if (contentOffSetX < 0) {
                contentOffSetX = 0
            }
            let val = contentOffSetX + menuBar.frame.size.width
            if (val > menuBar.contentSize.width) {
                contentOffSetX = menuBar.contentSize.width - menuBarWidth
            }
            menuBar.setContentOffset(CGPoint(x: contentOffSetX, y: 0), animated: animated)
        }
        
    }
    
    deinit {
//        print("tabview deinit")
    }
}

extension TabView: UIScrollViewDelegate, BaseScrollViewDelegate {
    func contentSizeUpdated(view: UIScrollView) {
        if view == menuBar {
            goToTab()
        }
    }
    func frameUpdated(view: UIScrollView) {
        //view.updateContentViewSize()
        
    }
    
    
}


