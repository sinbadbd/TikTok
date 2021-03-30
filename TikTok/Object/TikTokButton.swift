//
//  TikTokButton.swift
//  TikTok
//
//  Created by Imran on 30/3/21.
//

import UIKit
//@available(iOS 13.0, *)
class TikTokButton: UIButton {

    convenience init(
        frame:CGRect = .zero,
        setTitle:String = "",
        bgColor:UIColor? = nil,
        textColor:UIColor? = nil,
//        setIcon:String? = nil,
        setImage:String? = nil,
        tintColor:UIColor? = nil
    )
    {
        self.init(frame : frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 4
        self.setTitle(setTitle.uppercased(), for: .normal)
//        self.setBackgroundImage(UIImage(systemName: "\(setIcon ?? "")"), for: .normal)
        self.setBackgroundImage(UIImage(named:"\( setImage ?? "")")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = tintColor
    }
    

}
