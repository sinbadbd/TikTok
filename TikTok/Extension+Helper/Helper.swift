//
//  Helper.swift
//  TikTok
//
//  Created by Imran on 20/3/21.
//

import UIKit


extension UIColor {
    var imageRepresentation : UIImage {
      let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
      UIGraphicsBeginImageContext(rect.size)
      let context = UIGraphicsGetCurrentContext()

      context?.setFillColor(self.cgColor)
      context?.fill(rect)

      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

    return image!
  }
}


extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
