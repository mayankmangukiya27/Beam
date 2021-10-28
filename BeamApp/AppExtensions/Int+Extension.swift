//
//  Int+Extension.swift

//

import Foundation

extension Int {
    
    func localizedString() -> String {
        let formatter: NumberFormatter = NumberFormatter()
        let identifier = PersistanceUtil.isLanguageArabic() ?  "AR" : "EN"
        formatter.locale = Locale(identifier: identifier)
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
extension Double {
    func localizedString() -> String {
        let formatter: NumberFormatter = NumberFormatter()
        let identifier = PersistanceUtil.isLanguageArabic() ? "AR" : "EN"
        formatter.locale = Locale(identifier: identifier)
        formatter.minimumFractionDigits = 1
        return formatter.string(from: NSNumber(value:self)) ?? "\(self)"
    }
}
