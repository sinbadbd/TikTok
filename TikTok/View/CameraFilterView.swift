//
//  CameraFilterView.swift
//  TikTok
//
//  Created by Imran on 5/4/21.
//

import UIKit

protocol CameraFilterProtocol: AnyObject {
    func flipCamera()
    func filterCamera()
    func flashCamera()
    func isShowView()
    func isHiddenView()
}


protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
    


class CameraFilterView: UIView {
    
    let cameraManager = CameraManager()
    let FiltersButtonx = UIButton()
    
    weak var delegate: CameraFilterProtocol?
    
    var isViewToggle: Bool = false
    
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
        flipButton.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        flipButton.tag = CameraTapItem.cameraSwitchbtn.rawValue
        
        let speedButton = UIButton()
        addSubview(speedButton)
        speedButton.position(top: flipButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        speedButton.centerXInSuper()
        speedButton.size(width:36, height: 36)
        let speedButtonBtnImage = UIImage(named: "speed")
        speedButton.setImage(speedButtonBtnImage , for: .normal)
        speedButton.setImageTintColor(UIColor.white)
         speedButton.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        speedButton.tag =  CameraTapItem.addSoundbtn.rawValue
        
        
        
        let FiltersButton = UIButton()
        addSubview(FiltersButton)
        FiltersButton.position(top: speedButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        FiltersButton.centerXInSuper()
        FiltersButton.size(width:36, height: 36)
        let FiltersButtonButtonBtnImage = UIImage(named: "image")
        FiltersButton.setImage(FiltersButtonButtonBtnImage , for: .normal)
        FiltersButton.setImageTintColor(UIColor.white)
        FiltersButton.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        FiltersButton.tag = CameraTapItem.filterBtn.rawValue
        
        
   
        addSubview(FiltersButtonx)
        FiltersButtonx.position(top: FiltersButton.bottomAnchor, insets: .init(top: 20, left: 5, bottom: 0, right: 5))
        FiltersButtonx.centerXInSuper()
        FiltersButtonx.size(width:30, height: 30)
        let FiltersButtonButtonBtnImagex = UIImage(named: "turn-off")
        FiltersButtonx.setImage(FiltersButtonButtonBtnImagex , for: .normal)
        FiltersButtonx.setImageTintColor(UIColor.white)
        FiltersButtonx.addTarget(self, action: #selector(tapBtnTapped), for: .touchUpInside)
        FiltersButtonx.tag = CameraTapItem.flash.rawValue
        
        
        
    }
    @objc func tapBtnTapped(_ sender:UIButton){
        if sender.tag == CameraTapItem.cameraSwitchbtn.rawValue {
            print(sender.tag)
            cameraManager.switchCamera()
  
        }else if sender.tag == CameraTapItem.filterBtn.rawValue {
            print("filter")
        
            delegate?.filterCamera()
            
        } else if sender.tag == CameraTapItem.flash.rawValue {
            print("hi")
            
            cameraManager.isCameraFlushEnable(flashToggle: true)
            if cameraManager.isFlash == true {
                
                let FiltersButtonButtonBtnImagex = UIImage(named: "flash")
                FiltersButtonx.setImage(FiltersButtonButtonBtnImagex , for: .normal)
                FiltersButtonx.setImageTintColor(UIColor.white)
            }else {
//                cameraManager.isCameraFlushEnable(flashToggle: false)
                let FiltersButtonButtonBtnImagex = UIImage(named: "turn-off")
                FiltersButtonx.setImage(FiltersButtonButtonBtnImagex , for: .normal)
                FiltersButtonx.setImageTintColor(UIColor.white)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
