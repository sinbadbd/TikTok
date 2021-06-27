//
//  CommentsVC.swift
//  TikTok
//
//  Created by Imran on 27/6/21.
//

import UIKit

class CommentsVC: UIViewController {

    var panGesture : UIPanGestureRecognizer!
    
//            panGesture = UIPanGestureRecognizer(target: self, action: #selector(animatePopUpView(sender:)))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
//        view.addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
        
//        panGesture = UIPanGestureRecognizer(target: self, action: #selector(animatePopUpView(sender:)))
        // Do any additional setup after loading the view.
        
        
               let dismissKeybordGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeybordGesture)
    }
    
    @objc func dismissKeyboard(){
        view.removeFromSuperview()
    }
   

}
