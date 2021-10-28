//
//  AppTextView.swift

//

import UIKit

@IBDesignable class AppTextView: UITextView {

    var externalLabel:AppLabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
        
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        self.clipsToBounds = true
        self.tintColor =  UIColor.AppColor.primary
        NotificationCenter.default.addObserver(self, selector: #selector(appTextViewDidChangeNotification), name: UITextView.textDidChangeNotification , object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBInspectable var txtColorCode:String = ControlConfig.ColorSlug.primary.rawValue {
        didSet {
            self.setTextColorFromCode()
        }
    }
    
    @IBInspectable var fontStyle:String = ControlConfig.FontStyleSlug.regular.rawValue {
        didSet {
            self.setFontStyleFromCode()
        }
    }
    @IBInspectable var fontSize:String = ControlConfig.FontSizeSlug.textField.rawValue {
        didSet {
            self.setFontSizeFromCode()
        }
    }
    
    @IBInspectable var exteranlPlaceholderColorCode:String = ControlConfig.ColorSlug.placeholder.rawValue {
        didSet {
            self.addExternalPlaceHolder()
        }
    }

    @IBInspectable var placeholderKey:String = "" {
        didSet {
            self.updateLocalizedPlaceholderText()
        }
    }

    @IBInspectable var showExternalPlacholder:Bool = false {
        didSet {
            if (showExternalPlacholder) {
                self.addExternalPlaceHolder()
            } else {
                self.removeExternalPlaceholder()
            }
        }
    }
    
    private func setFontStyleFromCode() {
        let code = ControlConfig.FontStyleSlug.build(rawValue: fontStyle)
        self.font = ControlConfig.fontForStyleCode(code, customStyle:self.font?.fontName, fontSize: self.font?.pointSize)
    }
    
    private func setFontSizeFromCode() {
        let floatValue = Float(fontSize) ?? Float(15)
        let newFontSize: CGFloat = CGFloat.init(floatValue)
        let code = ControlConfig.FontSizeSlug.build(rawValue:fontSize)
        self.font = ControlConfig.fontForSizeCode(code, customSize: newFontSize,  fontName: self.font?.fontName)
    }
    
    private func setTextColorFromCode() {
        let code = ControlConfig.ColorSlug.build(rawValue: txtColorCode)
        self.textColor = ControlConfig.colorForCode(code , customColor: self.textColor)
    }
    
    private func addExternalPlaceHolder() {
        if(self.showExternalPlacholder) {
            if self.externalLabel == nil {
                self.externalLabel = AppLabel.init(frame: .zero)
                self.externalLabel?.textAlignment = .natural
            }
            self.externalLabel!.font = UIFont.init(name: UIFont.AppFont.regular.localizedString, size: 15)
            let code = ControlConfig.ColorSlug.build(rawValue: exteranlPlaceholderColorCode)
            self.externalLabel?.textColor = ControlConfig.colorForCode(code , customColor: self.textColor)
            self.externalLabel!.translatesAutoresizingMaskIntoConstraints = false
            self.externalLabel!.backgroundColor = .clear
            if self.externalLabel?.superview == nil {
                self.superview?.addSubview(self.externalLabel!)
            }
            self.externalLabel?.isHidden = false
            self.externalLabel!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(self).offset(16)
//                make.height.equalTo(self)
                make.left.equalTo(self).offset(15)
                make.right.equalTo(self).offset(-15)
            }
            self.updateLocalizedPlaceholderText()
        }
    }
    
    private func removeExternalPlaceholder() {
        if(self.showExternalPlacholder) {
            self.externalLabel?.removeFromSuperview()
        }
    }
    
    private func updateLocalizedPlaceholderText() {
        self.externalLabel?.text = self.placeholderKey.localizedString
    }
    
    @objc private func appTextViewDidChangeNotification() {
         self.externalLabel?.isHidden =  !self.text.isEmpty
    }
}

