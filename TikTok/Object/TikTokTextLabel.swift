//
//  TikTokTextLabel.swift
//  TikTok
//
//  Created by Imran on 30/3/21.
//

import UIKit
class TikTokTextLabel :UITextField {
    
    
    var iconPadding = 8
    var size = 20
    
    var leftTextFieldPaddding:CGFloat = 40
    var rightTextFieldPadding:CGFloat = 45
    var padding:UIEdgeInsets!
    
    convenience init(frame: CGRect = .zero,placeholderText:String? = "placeholderText",_ icon: UIImage?) {
        self.init(frame: frame)
        
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.placeholder = placeholderText
        self.backgroundColor = UIColor.white
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 14)
        self.layer.cornerRadius = 6
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        
        // MARK: IMAGE/SHOW-HIDE3
        if icon == nil {
            size = 0
            iconPadding = 0
            leftTextFieldPaddding = 20
            rightTextFieldPadding = 30
        }else {
            self.leftIcon(icon)
        }
        padding = UIEdgeInsets(top: 0, left: leftTextFieldPaddding, bottom: 0, right: 5)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    func leftIcon(_ icon: UIImage?){
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+iconPadding, height: size))
        let iconView  = UIImageView(frame: CGRect(x: iconPadding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        self.leftView = outerView
        self.leftViewMode = .always
    }
    
    
}

