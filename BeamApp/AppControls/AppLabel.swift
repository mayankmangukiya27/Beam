//
//  AppLabel.swift

//

import UIKit

class AppLabel: UILabel {
    
    var  border :CALayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateLocalizedText()
        self.updateUpperCaseText()
    }
    
    @IBInspectable var textString:String = "" {
        didSet {
            self.updateLocalizedText()
        }
    }
    
    @IBInspectable var shouldUpperCase:Bool = false {
        didSet {
            self.updateUpperCaseText()
        }
    }
    
    @IBInspectable var showUnderLine:Bool = false
        {
        didSet
        {
            self.setUnderLine()
            
        }
    }
    
    @IBInspectable var borderColorCode:String = ControlConfig.ColorSlug.custom.rawValue {
        didSet {
            self.setBorderColorFromCode()
        }
    }
    
    @IBInspectable var txtColorCode:String = ControlConfig.ColorSlug.custom.rawValue {
        didSet {
            self.setTextColorFromCode()
        }
    }
    
    @IBInspectable var fontStyle:String = ControlConfig.FontStyleSlug.regular.rawValue {
        didSet {
            self.setFontStyleFromCode()
        }
    }
    
    @IBInspectable var fontSize:String = ControlConfig.FontSizeSlug.custom.rawValue {
        didSet {
            self.setFontSizeFromCode()
        }
    }
    
    @IBInspectable var bgColorCode:String = ControlConfig.ColorSlug.custom.rawValue {
        didSet {
            self.setBgColorFromCode()
            
        }
    }
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
   
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    
    func updateUpperCaseText() {
        self.text = self.shouldUpperCase ? self.textString.localizedString.uppercased() : self.textString.localizedString
    }
    
    func updateLocalizedText() {
        self.text = self.textString.localizedString
        
    }
    
    func setBorderColorFromCode() {
        let code = ControlConfig.ColorSlug.build(rawValue:self.borderColorCode)
        self.borderColor = ControlConfig.colorForCode(code , customColor:  self.borderColor)
    }
    
    func setTextColorFromCode() {
        let code = ControlConfig.ColorSlug.build(rawValue:txtColorCode)
        self.textColor = ControlConfig.colorForCode(code , customColor: self.textColor)
    }
    
    func setFontStyleFromCode() {
        let code = ControlConfig.FontStyleSlug.build(rawValue:fontStyle)
        self.font = ControlConfig.fontForStyleCode(code, customStyle:self.font.fontName, fontSize: self.font.pointSize)
    }
    
    func setFontSizeFromCode() {
        let code = ControlConfig.FontSizeSlug.build(rawValue:fontSize)
        self.font = ControlConfig.fontForSizeCode(code, customSize: self.font.pointSize,  fontName: self.font.fontName)
    }
    
    func setBgColorFromCode() {
        let code = ControlConfig.ColorSlug.build(rawValue:bgColorCode)
        self.backgroundColor = ControlConfig.colorForCode(code , customColor: self.backgroundColor)
    }
    
    public func setUnderLine() {
        guard  showUnderLine else
        {
            return
        }
        guard  border == nil else
        {
            
            resetBorderFrame()
            return
        }
        
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        
        border = CALayer()
        self.layer.addSublayer(border!)
        resetBorderFrame()
        
    }
    
    func resetBorderFrame() {
        guard  let border = self.border else {
            return
        }
        let code = ControlConfig.ColorSlug.build(rawValue:txtColorCode)
        let color  = ControlConfig.colorForCode(code , customColor: UIColor.AppColor.primary)
        border.backgroundColor = color.cgColor
        let space:CGFloat = 0
        
        var rect: CGRect = self.frame //get frame of label
        rect.size = (self.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: self.font.fontName , size: self.font.pointSize)!]))! //Calculate as per label font
        
//        let frame = CGRect(x: 0, y: (self.frame.size.height) + space, width: (self.frame.size.width), height: 1.5)
        let frame = CGRect(x: 0, y: (rect.height) + space, width: (rect.width), height: 1.0)
        border.frame = frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resetBorderFrame()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTextColorFromCode()
        self.setFontStyleFromCode()
        self.setFontSizeFromCode()
        self.setBgColorFromCode()
        self.updateLocalizedText()
        self.setBorderColorFromCode()
        self.updateUpperCaseText()
    }
}
