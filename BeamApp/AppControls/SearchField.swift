//
//  SearchField.swift

//

import Foundation
import UIKit

class SearchField: AppField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func commonInit() {
        super.commonInit()
      //  self.leftImage = UIImage.init(named: "searchMag")
        self.rightImage = UIImage.init(named: "searchIcon")
       // self.showExternalPlacholder = true
        //self.backgroundColor = UIColor.AppColor.clear
//        self.attributedPlaceholder = NSAttributedString(string:self.placeholderKey.localizedString, attributes:[NSAttributedString.Key.foregroundColor: UIColor.AppColor.darkGray])

    }
    override func updatePadding() {
        super.updatePadding()
        padding.top = 0
    }
    
}
