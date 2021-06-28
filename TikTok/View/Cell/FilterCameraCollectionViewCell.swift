//
//  FilterCameraCollectionViewCell.swift
//  TikTok
//
//  Created by Imran on 2/5/21.
//

import UIKit

class FilterCameraCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "FilterCameraCollectionViewCell"
    
    let filerImage : UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    let filterTitle : UILabel = {
        let label = UILabel()
        label.text = "1"
        return label
    }()
    
    override var isSelected: Bool {
            didSet {
//               contentView.backgroundColor = isSelected ? .red : .clear
//                contentView.layer.cornerRadius = 30
                self.filerImage.layer.borderColor = isSelected  ? UIColor.red.cgColor : UIColor.clear.cgColor
                filterTitle.textColor = isSelected  ? UIColor.red : UIColor.black
                self.filerImage.layer.borderWidth = 2
            }
    }
     override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
//        backgroundColor = .blue
         layer.cornerRadius = 30
        contentView.isUserInteractionEnabled = true
        
        addSubview(filerImage)
        filerImage.position(top: topAnchor, left: leadingAnchor, right: trailingAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        filerImage.size(width:60,height: 60)
        filerImage.centerXInSuper()
        filerImage.backgroundColor = .yellow
        filerImage.layer.cornerRadius = 30
        
        addSubview(filterTitle)
        filterTitle.position(top: filerImage.bottomAnchor,insets: .init(top: 5, left: 0, bottom: 0, right: 0))
        filterTitle.centerXInSuper()
        filterTitle.text = "c1"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
