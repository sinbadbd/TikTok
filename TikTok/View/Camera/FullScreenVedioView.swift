//
//  FullScreenVedioView.swift
//  TikTok
//
//  Created by Imran on 22/4/21.
//

import UIKit
import AVFoundation

@available(iOS 13.0, *)
class FullScreenVedioView: UIView {
    
    var post : Post?
    var videoURL: URL? // MARK:: Fix : refactor
 
    var playerView: MediaPlayerView? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        presentPlayerView()
 
        let dismissKeybordGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(dismissKeybordGesture)
    }
    
    
    func presentPlayerView(){
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            if let url = videoURL {
                playerView = MediaPlayerView(frame:  frame, videoURL: url)
                 addSubview(playerView!)
                playerView?.fitToSuper()
                playerView?.play()
            }
        }  
    }
    
    @objc func dismissKeyboard(){
       removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
