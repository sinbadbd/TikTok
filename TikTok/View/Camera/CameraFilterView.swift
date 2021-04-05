//
//  CameraFilterView.swift
//  TikTok
//
//  Created by Imran on 5/4/21.
//

import UIKit

class CameraFilterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let flipButton = UIButton()
        addSubview(flipButton)
        flipButton.position(top:  topAnchor, insets: .init(top: 5, left: 5, bottom: 0, right: 5))
        flipButton.centerXInSuper()
        flipButton.size(width:36, height: 36)
        let btnImage = UIImage(named: "flip")
        flipButton.setImage(btnImage , for: .normal)
        flipButton.setImageTintColor(UIColor.white)
//        flipButton.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        flipButton.tag = CameraTapItem.cameraSwitchbtn.rawValue
        
        let speedButton = UIButton()
        addSubview(speedButton)
        speedButton.position(top: flipButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        speedButton.centerXInSuper()
        speedButton.size(width:36, height: 36)
        let speedButtonBtnImage = UIImage(named: "speed")
        speedButton.setImage(speedButtonBtnImage , for: .normal)
        speedButton.setImageTintColor(UIColor.white)
//        speedButton.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        speedButton.tag =  CameraTapItem.addSoundbtn.rawValue
        
        
        
        let FiltersButton = UIButton()
        addSubview(FiltersButton)
        FiltersButton.position(top: speedButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        FiltersButton.centerXInSuper()
        FiltersButton.size(width:36, height: 36)
        let FiltersButtonButtonBtnImage = UIImage(named: "image")
        FiltersButton.setImage(FiltersButtonButtonBtnImage , for: .normal)
        FiltersButton.setImageTintColor(UIColor.white)
//        FiltersButton.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        FiltersButton.tag = CameraTapItem.filterBtn.rawValue
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
