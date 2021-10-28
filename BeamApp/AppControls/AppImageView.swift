//
//  AppImageView.swift

//

import UIKit
@IBDesignable
class AppImageView: UIImageView {
    
    @IBInspectable var CornerRadius : CGFloat = 0.0{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var circular : Bool = false{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    func applyCornerRadius()
    {
        if(self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderWidth = CGFloat(self.layer.borderWidth)
        }else {
            self.layer.cornerRadius = CornerRadius
            self.layer.masksToBounds = true
            self.layer.borderWidth = CGFloat(self.layer.borderWidth)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
    
}

