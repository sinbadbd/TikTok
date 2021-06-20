//
//  PhotoGalleryCell.swift
//  TikTok
//
//  Created by Imran on 20/6/21.
//

import UIKit

class PhotoGalleryCell: UICollectionViewCell {
    
    static let identify = "PhotoGalleryCell"
    
    let photoImageView : UIImageView = {
            let image = UIImageView()
            return image
        }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .systemGray
        addSubview(photoImageView)
        photoImageView.fitToSuper()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
