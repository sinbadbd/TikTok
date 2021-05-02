//
//  FilterCameraDesignView.swift
//  TikTok
//
//  Created by Imran on 2/5/21.
//

import UIKit
class FilterCameraDesignView: UIView {
    
    let filterView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let mainContentView : UIView = {
        let view = UIView()
//        view.backgroundColor = .green
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainContentView)
        mainContentView.fitToSuper()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleDismiss))
        mainContentView.addGestureRecognizer(tapGesture)
        
        
        mainContentView.addSubview(filterView)
        filterView.position( left: mainContentView.leadingAnchor, bottom: mainContentView.bottomAnchor, right: mainContentView.trailingAnchor)
        filterView.size(height:200)
        
    }
    
    
    @objc func handleDismiss(){
       removeFromSuperview()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
