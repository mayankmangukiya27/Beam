//
//  ViewAnimationExtension.swift

//

import Foundation
import UIKit
extension UIView {
    // Using SpringWithDamping
    func shake() {
        self.transform = CGAffineTransform(translationX: 30, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

extension UICollectionView{
    open override func awakeFromNib() {
        if PersistanceUtil.isLanguageArabic(){
            self.semanticContentAttribute = .forceRightToLeft
        }
    }
}
