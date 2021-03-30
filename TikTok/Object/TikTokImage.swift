//
//  TikTokImage.swift
//  TikTok
//
//  Created by Imran on 30/3/21.
//

import UIKit

class TikTokImage: UIImageView {
    
    convenience override init(frame: CGRect = .zero){
        self.init(frame: frame)
        
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
