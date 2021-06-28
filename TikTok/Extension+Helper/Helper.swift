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

func getAttributedText(string:String, font:UIFont, color:UIColor, lineSpace:Float, alignment:NSTextAlignment) -> NSMutableAttributedString{
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment=alignment
    textStyle.lineSpacing=CGFloat(lineSpace)
    //paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
    let aMutableString = NSMutableAttributedString(
        string: string,
        attributes:[NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:textStyle,NSAttributedString.Key.foregroundColor:color])
    return aMutableString
}


 
extension UIImage {

    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)

        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }

        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)

        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
}
