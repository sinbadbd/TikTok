//
//  LoadingAnimationView.swift
//  TikTok
//
//  Created by Imran on 6/4/21.
//

import Foundation
import Lottie

class LottieAnimationView: LottieView{
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(LottieAnimationView.loadingAnimation)
        backgroundColor = .blue
        alpha = 0.5
//        loadingAnimation.fitToSuper()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var loadingAnimation: AnimationView = {
        let animationView = AnimationView(name: "LoadingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.8
        animationView.loopMode = .loop
//        addSubview(animationView)
//        bringSubviewToFront(animationView)
        
        animationView.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        })
        return animationView
    }()
    
    func animationPlay(){
//         loadingAnimation.backgroundColor = .red
        LottieAnimationView.loadingAnimation.alpha = 1
        LottieAnimationView.loadingAnimation.play()
    }
    
    func animationStop(){
        LottieAnimationView.loadingAnimation.alpha = 0
        LottieAnimationView.loadingAnimation.stop()
    }
}
