//
//  MenuBarCell.swift
//  TikTok
//
//  Created by Imran on 28/6/21.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    static let identify = "UICollectionViewCell"
    
    let photoImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.gray
        return image
    }()
    let margin:CGFloat = 16
    
    override var isHighlighted: Bool {
        didSet {
            photoImageView.tintColor = isHighlighted ? UIColor.black : UIColor.gray
        }
    }

    override var isSelected: Bool {
        didSet {
            photoImageView.tintColor = isSelected ? UIColor.black : UIColor.gray
        }

    }
//    override var isSelected: Bool{
//      didSet{
//        if self.isSelected
//        {
//          self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//          self.contentView.backgroundColor = UIColor.red
//          self.photoImageView.isHidden = false
//        }
//        else
//        {
//          self.transform = CGAffineTransform.identity
//          self.contentView.backgroundColor = UIColor.gray
//          self.photoImageView.isHidden = true
//        }
//      }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .green
        
        addSubview(photoImageView)
        photoImageView.fitToSuper(insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        photoImageView.image?.withRenderingMode(.alwaysTemplate)
 
//        photoImageView.image = image?.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        photoImageView.size(width:24,height: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
