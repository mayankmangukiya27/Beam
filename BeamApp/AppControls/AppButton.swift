//
//  AppButton.swift

//

import UIKit

@IBDesignable class AppButton: UIButton {
    
    public enum ButtonStyle:String
    {
        case custom = "custom"
        case primary = "primary"
        case secondary = "light"
        case primaryButton = "primaryButton"
        case addButton = "addButton"

        static func build(rawValue:String) -> ButtonStyle {
            return ButtonStyle(rawValue: rawValue) ?? .custom
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateLocalizedText()
        self.updateUpperCaseText()
    }
    var  border :CALayer?
    
    @IBInspectable var styleValue:String = ButtonStyle.custom.rawValue
        {
        didSet
        {
            
            let style = ButtonStyle.init(rawValue: styleValue)
            guard style != ButtonStyle.custom else
            {
                return
            }
            self.fontSize =  ControlConfig.FontSizeSlug.button.rawValue
            self.fontStyle =  ControlConfig.FontStyleSlug.regular.rawValue
            
            if style == ButtonStyle.primary
            {
                
                self.txtColorCode = ControlConfig.ColorSlug.white.rawValue
                self.bgColorCode = ControlConfig.ColorSlug.primary.rawValue
                self.borderColorCode = ControlConfig.ColorSlug.primary.rawValue
                self.borderWidth = 2.0
                //                self.cornerRadius = 8
                
                
            }
            else if style == ButtonStyle.secondary
            {
                self.txtColorCode = ControlConfig.ColorSlug.primary.rawValue
                self.bgColorCode = ControlConfig.ColorSlug.white.rawValue
                self.borderColorCode = ControlConfig.ColorSlug.primary.rawValue
                self.borderWidth = 2.0
                
                
                
            }
            else if style == ButtonStyle.primaryButton
            {
                self.txtColorCode = ControlConfig.ColorSlug.white.rawValue
                self.bgColorCode = ControlConfig.ColorSlug.accent.rawValue
                self.borderColorCode = ControlConfig.ColorSlug.accent.rawValue
            }
            else if style == ButtonStyle.addButton
            {
                self.txtColorCode = ControlConfig.ColorSlug.white.rawValue
                self.bgColorCode = ControlConfig.ColorSlug.accent.rawValue
                self.borderColorCode = ControlConfig.ColorSlug.accent.rawValue
            }
            
            
        }
    }
    @IBInspectable var shouldUpperCase:Bool = false
        {
        didSet
        {
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
    @IBInspectable var textString:String = ""
        {
        didSet
        {
            self.updateLocalizedText()
            
        }
    }
    @IBInspectable var borderColorCode:String = ControlConfig.ColorSlug.primary.rawValue
        {
        didSet
        {
            self.setBorderColorFromCode()
            
        }
    }
    
    @IBInspectable var txtColorCode:String = ControlConfig.ColorSlug.primary.rawValue
        {
        didSet
        {
            self.setTextColorFromCode()
            self.setUnderLine()
            
            
        }
    }
    
    
    @IBInspectable var fontStyle:String = ControlConfig.FontStyleSlug.regular.rawValue
        {
        didSet
        {
            self.setFontStyleFromCode()
            
        }
    }
    
    @IBInspectable var fontSize:String = ControlConfig.FontSizeSlug.button.rawValue
        {
        didSet
        {
            self.setFontSizeFromCode()
            
        }
    }
    
    
    
    @IBInspectable var bgColorCode:String = ControlConfig.ColorSlug.primary.rawValue
        {
        didSet
        {
            self.setBgColorFromCode()
            
        }
    }
    
    func updateUpperCaseText() {
        self.setTitle(self.shouldUpperCase ? self.textString.localizedString.uppercased() : self.textString.localizedString, for: .normal)
    }
    
    func updateLocalizedText()
    {
        self.setTitle(self.textString.localizedString, for: .normal)
    }
    func setBorderColorFromCode()
    {
        let code = ControlConfig.ColorSlug.build(rawValue:self.borderColorCode)
        self.borderColor = ControlConfig.colorForCode(code , customColor: self.borderColor)
    }
    func setTextColorFromCode()
    {
        let code = ControlConfig.ColorSlug.build(rawValue:txtColorCode)
        self.setTitleColor(ControlConfig.colorForCode(code , customColor: self.titleColor(for: .normal)), for: .normal)
    }
    func setFontStyleFromCode()
    {
        let code = ControlConfig.FontStyleSlug.build(rawValue:fontStyle)
        self.titleLabel?.font = ControlConfig.fontForStyleCode(code, customStyle:self.titleLabel?.font.fontName, fontSize: self.titleLabel?.font.pointSize)
        
        
    }
    func setFontSizeFromCode()
    {
        let code = ControlConfig.FontSizeSlug.build(rawValue:fontSize)
        self.titleLabel?.font = ControlConfig.fontForSizeCode(code, customSize: self.titleLabel?.font.pointSize,  fontName: self.titleLabel?.font.fontName)
        
    }
    func setBgColorFromCode()
        
    {
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
        self.titleLabel?.layer.addSublayer(border!)
        resetBorderFrame()
        
    }
    func resetBorderFrame()
    {
        
        guard  let border = self.border else
        {
            return
        }
        let code = ControlConfig.ColorSlug.build(rawValue:txtColorCode)
        let color  = ControlConfig.colorForCode(code , customColor: UIColor.AppColor.primary)
        border.backgroundColor = color.cgColor
        let space:CGFloat = 0
        let frame = CGRect(x: 0, y: (self.titleLabel?.frame.size.height)! + space, width: (self.titleLabel?.frame.size.width)!, height: 1.5)
        border.frame = frame
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resetBorderFrame()
    }
    
}
class ResizableAppButton: AppButton {
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        
        return desiredButtonSize
    }
}
