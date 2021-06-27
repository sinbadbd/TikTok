//
//  AppFontName.swift
//  TikTok
//
//  Created by Imran on 27/6/21.
//

import UIKit

//struct AppFontName {
//    static let Light            = "Lato-Light.tff"
//    static let LightItalic       = "Lato-LightItalic.tff"
//    static let Bold             = "Lato-Bold.tff"
//    static let Thin             = "Lato-Thin.tff"
//    static let ThinItalic      = "Lato-ThinItalic.tff"
//    static let Regular         = "Lato-Regular.ttf"
//
//
//
//}

//extension UIFont {
//    
//    static func AppFontLight(ofSize size: CGFloat) -> UIFont {
//          UIFont(name: AppFontName.Light, size: size)!
//    }
//    static func AppFontLightItalic(ofSize size: CGFloat) -> UIFont {
//          UIFont(name: AppFontName.LightItalic, size: size)!
//    }
//    static func AppFontBold(ofSize size: CGFloat) -> UIFont {
//          UIFont(name: AppFontName.Bold, size: size)!
//    }
//    static func AppFontThin(ofSize size: CGFloat) -> UIFont {
//          UIFont(name: AppFontName.Thin, size: size)!
//    }
//    
//    static  func AppFontThinItalic(ofSize size: CGFloat) -> UIFont {
//          UIFont(name: AppFontName.ThinItalic, size: size)!
//    }
//    static func AppFontRegular(ofSize size: CGFloat) -> UIFont {
//        UIFont(name: AppFontName.Regular, size: size)!
//    }
//    
//    
//}
//MARK: NOT WORKING.....




//struct AppFontName {
//    static let Light            = "Lato-Light.tff"
//    static let LightItalic       = "Lato-LightItalic.tff"
//    static let Bold             = "Lato-Bold.tff"
//    static let Thin             = "Lato-Thin.tff"
//    static let ThinItalic      = "Lato-ThinItalic.tff"
//    static let Regular         = "Lato-Regular.ttf"
//
//
//}
//
//extension UIFontDescriptor.AttributeName {
//    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
//}
//
//extension UIFont {
//    static var isOverrided: Bool = false
//
//    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.Regular, size: size)!
//    }
//
//    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.Bold, size: size)!
//    }
//
//    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.ThinItalic, size: size)!
//    }
//
//    @objc convenience init(myCoder aDecoder: NSCoder) {
//        guard
//            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
//            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
//                self.init(myCoder: aDecoder)
//                return
//        }
//        var fontName = ""
//        switch fontAttribute {
//        case "CTFontRegularUsage":
//            fontName = AppFontName.Regular
//        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
//            fontName = AppFontName.Bold
//        case "CTFontObliqueUsage":
//            fontName = AppFontName.ThinItalic
//        default:
//            fontName = AppFontName.Regular
//        }
//        self.init(name: fontName, size: fontDescriptor.pointSize)!
//    }
//
//    class func overrideInitialize() {
//        guard self == UIFont.self, !isOverrided else { return }
//
//        // Avoid method swizzling run twice and revert to original initialize function
//        isOverrided = true
//
//        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
//            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
//            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
//        }
//
//        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
//            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
//            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//        }
//
//        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
//            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
//            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//        }
//
//        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
//            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
//            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
//        }
//    }
//}
