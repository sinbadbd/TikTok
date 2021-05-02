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
    var delegate: didSelectIndexItem?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
        backgroundColor = .blue
        layer.cornerRadius = 30
        contentView.isUserInteractionEnabled = true
        
        addSubview(filerImage)
        filerImage.fitToSuper()
        filerImage.backgroundColor = .yellow
        filerImage.layer.cornerRadius = 30

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
