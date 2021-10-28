//
//  RadioButton.swift

//

import UIKit

class RadioButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let  emptyImage = UIImage.init(named: "RadioEmpty") ?? UIImage()
    let  fillImage = UIImage.init(named: "RadioFill") ?? UIImage()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let checkBoxImage = (empty: emptyImage.withRenderingMode(.alwaysOriginal), fill :fillImage.withRenderingMode(.alwaysOriginal))

        self.setImage(checkBoxImage.empty, for: .normal)
        self.setImage(checkBoxImage.fill, for: .selected)
        self.isUserInteractionEnabled = false
        self.adjustsImageWhenHighlighted = false
        self.tintColor = .clear

    }
    override var intrinsicContentSize: CGSize
        {
        let checkBoxImage = (empty: emptyImage.withRenderingMode(.alwaysOriginal), fill :fillImage.withRenderingMode(.alwaysOriginal))

        return checkBoxImage.empty.size
        }
}
