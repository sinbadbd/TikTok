//
//  CameraPreviewVC.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import UIKit

class CameraPreviewVC: UIViewController {

    
    let captureImage = UIImageView()
    var image : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(captureImage)
        captureImage.fitToSuper()
        captureImage.image = image
//        captureImage.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
