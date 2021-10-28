//
//  UIProgressView+Extension.swift

//

import UIKit

@IBDesignable extension UIProgressView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.sublayers![1].cornerRadius
        }
        set {
            layer.sublayers![1].cornerRadius = newValue
            self.subviews[1].clipsToBounds = true
        }
    }
}
