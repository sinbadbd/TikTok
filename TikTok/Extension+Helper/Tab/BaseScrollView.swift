//
//  BaseScrollView.swift
//  TikTok
//
//  Created by Imran on 20/6/21.
//

import Foundation

import UIKit

protocol BaseScrollViewDelegate: AnyObject {
    func frameUpdated(view:UIScrollView)
    func contentSizeUpdated(view:UIScrollView)
    func layoutSubviewsCalled(view:UIScrollView)
}

extension BaseScrollViewDelegate {//for optional
    func frameUpdated(view:UIScrollView){}
    func contentSizeUpdated(view:UIScrollView){}
    func layoutSubviewsCalled(view:UIScrollView){}
}

class BaseScrollView: UIScrollView {

    
    weak var baseDelegate: BaseScrollViewDelegate?
    var isContentsizeSet = false
    //var delegate : BaseScrollViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialTask()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialTask()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseDelegate?.layoutSubviewsCalled(view: self)
        if self.contentSize.width>0 {
            if !isContentsizeSet {
                isContentsizeSet = true
                baseDelegate?.contentSizeUpdated(view: self)
            }
        }
        
    }
    
    func initialTask(){
        self.addObserver(self, forKeyPath: "self.bounds", options: .new, context: nil)//Only for Swift 5
        setupView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {//Only for Swift 5
        if keyPath == "self.bounds" {
            //YourLayer.frame = YourView.bounds
            frameUpdated()
            return
        }
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
    
    func setupView(){}
    func frameUpdated(){
        baseDelegate?.frameUpdated(view: self)
    }
  
    deinit {
            removeObserver(self, forKeyPath: "self.bounds")
        }

}


