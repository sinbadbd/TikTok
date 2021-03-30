//
//  UIView+Extension.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import Foundation
import UIKit

import Foundation
import UIKit

extension UIView {
    
    @discardableResult
    func position(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, insets: UIEdgeInsets = .zero) -> LayoutConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var layoutConstraints = LayoutConstraints()
        
        if let top = top {
            layoutConstraints.top = topAnchor.constraint(equalTo: top, constant: insets.top)
        }
        
        if let left = left {
            layoutConstraints.left = leadingAnchor.constraint(equalTo: left, constant: insets.left)
        }
        
        if let bottom = bottom {
            layoutConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
        }
        
        if let right = right {
            layoutConstraints.right = trailingAnchor.constraint(equalTo: right, constant: -insets.right)
        }
        
        [layoutConstraints.top, layoutConstraints.left, layoutConstraints.bottom, layoutConstraints.right].forEach{ $0?.isActive = true }
        
        return layoutConstraints
    }
    
    @discardableResult
    func size(wAnchor:NSLayoutConstraint? = nil, hAnchor:NSLayoutConstraint? = nil, width: CGFloat = 0, height: CGFloat = 0, dimensionWidth:NSLayoutDimension? = nil, dimensionHeight:NSLayoutDimension? = nil, widthPriority:Float? = 1000, heightPriority:Float? = 1000 ) -> LayoutConstraints {
        
        //translatesAutoresizingMaskIntoConstraints = false
        var layoutConstraints = LayoutConstraints()
        
        if width != 0 {
            layoutConstraints.width = widthAnchor.constraint(equalToConstant: width)
        }else if wAnchor != nil {
            layoutConstraints.width = wAnchor
        }else if dimensionWidth != nil {
            layoutConstraints.width = widthAnchor.constraint(equalTo: dimensionWidth!)
        }
        
        if height != 0 {
            layoutConstraints.height = heightAnchor.constraint(equalToConstant: height)
        }else if hAnchor != nil {
            layoutConstraints.height = hAnchor
        }else if dimensionHeight != nil {
            layoutConstraints.height = heightAnchor.constraint(equalTo: dimensionHeight!)
        }
        layoutConstraints.width?.priority = UILayoutPriority(rawValue: widthPriority!)
        layoutConstraints.height?.priority = UILayoutPriority(rawValue: heightPriority!)
        [layoutConstraints.width, layoutConstraints.height].forEach{ $0?.isActive = true }
        
        return layoutConstraints
    }
    
    @discardableResult
    func sizeFrom(view:UIView) -> LayoutConstraints {
        
        //translatesAutoresizingMaskIntoConstraints = false
        var layoutConstraints = LayoutConstraints()
        
        layoutConstraints.width = widthAnchor.constraint(equalTo: view.widthAnchor)
        layoutConstraints.height = heightAnchor.constraint(equalTo: view.heightAnchor)
        
        [layoutConstraints.width, layoutConstraints.height].forEach{ $0?.isActive = true }
        
        return layoutConstraints
    }
    
    
    
    func updateWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func updateHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func fitToSuper(insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: insets.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -insets.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: insets.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -insets.right).isActive = true
        }
    }
    
    func centerInSuper(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuper() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuper() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
}

struct LayoutConstraints {
    var top, left, bottom, right, width, height: NSLayoutConstraint?
}


public extension UIStackView {
    /// SwifterSwift: Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views (default: 0.0).
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis (default: .fill).
    ///   - distribution: The distribution of the arranged views along the stack view’s axis (default: .fill).
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    /// SwifterSwift: Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    /// SwifterSwift: Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
