//
//  UIColor+Extension.swift

//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct AppColor {
        static let clear = UIColor.clear
        static let white = UIColor.white
        static let black = UIColor.black
        static let primary = UIColor.init(named: "Primary") ?? UIColor.init(netHex: 0x882076)
        static let accent = UIColor.init(named: "AccentColor")  ?? UIColor.clear
        static let placeholder = UIColor.init(named: "Placeholder") ?? UIColor.init(netHex: 0xBBBBBB)
        static let bgColor = UIColor.init(named: "BgColor")  ?? UIColor.clear
        static let text = UIColor.init(named: "Text") ?? UIColor.clear
        static let border = UIColor.init(named: "Border") ?? UIColor.clear
        
        static let primaryDark = UIColor.init(named: "darkColor") ?? UIColor.init(netHex: 0x02343B)
        static let primarySemiDark = UIColor.init(named: "lightColor") ?? UIColor.init(netHex: 0x027E8B)
        static let inputText = UIColor.init(named: "InputText") ?? UIColor.clear
        static let buttonText = UIColor.init(named: "ButtonText") ?? UIColor.clear
        static let navTintColor = UIColor.init(named: "NavTintColor") ?? UIColor.clear
        static let buttonSelection = UIColor.init(named: "ButtonSelection") ?? UIColor.init(netHex: 0x37B1C0)
        static let searchText = UIColor.init(named: "SearchText") ?? UIColor.init(netHex: 0x475761)
        static let interestSelect = UIColor.init(named: "InterestSelect") ?? UIColor.init(netHex: 0x022022)
        static let interestBorder = UIColor.init(named: "InterestBorder") ?? UIColor.init(netHex: 0x37B1C0)
        static let cellBtnBg = UIColor.init(named: "CellBtnBg") ?? UIColor.init(netHex: 0x022022)
        static let separator = UIColor.init(named: "Separator") ?? UIColor.init(netHex: 0xFFFFFF)
        static let contactBorder = UIColor.init(named: "ContactBorder") ?? UIColor.init(netHex: 0x37B1C0)
        static let viewBackGround = UIColor.init(named: "ViewBackground") ?? UIColor.init(netHex: 022022)
        static let imagBackground = UIColor.init(named: "ImagBackground") ?? UIColor.init(netHex: 022022)
        static let progressBar = UIColor.init(named: "ProgressBar") ?? UIColor.init(netHex: 0x37B1C0)
        
       
        
    }
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
