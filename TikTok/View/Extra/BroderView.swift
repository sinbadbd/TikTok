//
//  BroderView.swift
//  TikTok
//
//  Created by Imran on 28/6/21.
//

import UIKit

class BroderView: UIView {
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = hexToUIColor(hex: "#ededed")
        size(height:1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
