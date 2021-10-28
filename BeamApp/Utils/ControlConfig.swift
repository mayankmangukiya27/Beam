//
//  ControlConfig.swift

//

import UIKit

struct ControlConfig {
    public enum ColorSlug:String {
        case custom = "custom"
        case clear = "clear"
        case white = "white"
        case black = "black"
        case primary = "primary"
        case accent = "accent"
        case placeholder = "placeholder"
        case text = "text"
        case border = "border"
        case inputText = "inputText"
        case buttonText = "buttonText"
        case navTintColor = "navTintColor"
        case searchText = "searchText"
        case cellBtnBg = "cellBtnBg"
        case separator = "separator"
        case contactBorder = "contactBorder"
        case progressBar = "progressBar"

        static func build(rawValue:String) -> ColorSlug {
            return ColorSlug(rawValue: rawValue) ?? .custom
        }
    }
    
    static func colorForCode(_ code: ColorSlug, customColor:UIColor? = nil) ->UIColor {
        switch code {
        case .custom:
            return customColor ?? .clear
        case .clear:
            return UIColor.clear
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .primary:
            return UIColor.AppColor.primary
        case .accent:
            return UIColor.AppColor.accent
        case .placeholder:
            return UIColor.AppColor.placeholder
        case .text:
            return UIColor.AppColor.text
        case .border:
            return UIColor.AppColor.border
        case .inputText:
            return UIColor.AppColor.inputText
        case .buttonText:
            return UIColor.AppColor.buttonText
        case .navTintColor:
            return UIColor.AppColor.navTintColor
        case .searchText:
            return UIColor.AppColor.searchText
        case .cellBtnBg:
            return UIColor.AppColor.cellBtnBg
        case .separator:
            return UIColor.AppColor.separator
        case .contactBorder:
            return UIColor.AppColor.contactBorder
        case .progressBar:
            return UIColor.AppColor.progressBar
        }
        
    }
    
    public enum FontStyleSlug:String {
        
        case custom = "custom"
        case regular = "regular"
        case bold = "bold"
        case boldItalic = "boldItalic"
        case italic = "italic"
        case medium = "medium"
        case semiBold = "semiBold"
        case light = "light"
        case extraBold = "extraBold"
        case extraLight = "extraLight"
        case semiBoldItalic = "semiBoldItalic"
        case lightItalic = "lightItalic"

        static func build(rawValue:String) -> FontStyleSlug {
            return FontStyleSlug(rawValue: rawValue) ?? .custom
        }
    }
    
    static func fontForStyleCode(_ code: FontStyleSlug, customStyle:String? = nil, fontSize:CGFloat?) -> UIFont {
        let fontName = customStyle ??  UIFont.AppFont.regular.localizedString
        let size = fontSize ??  14
        
        switch code {
        case .custom:
            return UIFont.init(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular:
            return UIFont.init(name: UIFont.AppFont.regular, size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont.init(name: UIFont.AppFont.bold, size: size) ?? UIFont.systemFont(ofSize: size)
        case .boldItalic:
            return UIFont.init(name: UIFont.AppFont.boldItalic, size: size) ?? UIFont.systemFont(ofSize: size)
        case .italic:
            return UIFont.init(name: UIFont.AppFont.italic, size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium:
            return UIFont.init(name: UIFont.AppFont.medium, size: size) ?? UIFont.systemFont(ofSize: size)
        case .semiBold:
            return UIFont.init(name: UIFont.AppFont.semiBold, size: size) ?? UIFont.systemFont(ofSize: size)
        case .light:
            return UIFont.init(name: UIFont.AppFont.light, size: size) ?? UIFont.systemFont(ofSize: size)
        case .extraBold:
            return UIFont.init(name: UIFont.AppFont.extraBold, size: size) ?? UIFont.systemFont(ofSize: size)
        case .extraLight:
            return UIFont.init(name: UIFont.AppFont.extraLight, size: size) ?? UIFont.systemFont(ofSize: size)
        case .semiBoldItalic:
            return UIFont.init(name: UIFont.AppFont.semiBoldItalic, size: size) ?? UIFont.systemFont(ofSize: size)
        case .lightItalic:
            return UIFont.init(name: UIFont.AppFont.lightItalic, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    public enum FontSizeSlug:String {
        case custom = "custom"
        case textField = "textField"
        case button = "button"
        case introHeader = "introHeader"
        static func build(rawValue:String) -> FontSizeSlug {
            return FontSizeSlug(rawValue: rawValue) ?? .custom
        }
    }
    
    static func fontForSizeCode(_ code: FontSizeSlug, customSize:CGFloat?, fontName:String?) -> UIFont {
        let name = fontName ??  UIFont.AppFont.regular
        let size = customSize ??  14
        
        switch code {
        case .custom:
            return UIFont.init(name: name, size: size)!
        case .textField:
            return UIFont.init(name: name, size: 15)!
        case .button:
            return UIFont.init(name: name, size: 16)!
        case .introHeader:
            return UIFont.init(name: name, size: 16)!
        }
    }
}






