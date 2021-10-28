//
//  String+Extension.swift

//

import Foundation
import UIKit

extension Optional where Wrapped == String

{
    var validString:String! {
        return self ?? ""
    }
    var isInValid: Bool {

        
        return self.validString.isEmpty
    }
    var isValid: Bool {
        
        return !self.isInValid
    }

}

extension NSMutableAttributedString {
    
    func setAttributesForText(textForAttribute: String, withColor color: UIColor? = nil, withFont: UIFont? = nil, shouldUnderLine: Bool = false) {
        
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        if let color = color {
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        if let font = withFont {
            self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        if shouldUnderLine {
            self.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }
    }
    
}

extension String
{
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    func toLongDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date
    }
        func htmlAttributedString() -> NSAttributedString? {
            guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
            guard let html = try? NSMutableAttributedString(
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil) else { return nil }
            return html
        }

    var html2AttributedString: NSAttributedString? {
         do {
             return try NSAttributedString(data: data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!,
                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                           documentAttributes: nil)
         } catch {
             print("error: ", error)
             return nil
         }
     }
     var html2String: String {
         return html2AttributedString?.string ?? ""
     }
    
    func utf8EncodedString()-> String {
        let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")

        let text = self.addingPercentEncoding(withAllowedCharacters:rfc3986Unreserved) ?? ""
         return text
    }
    var localizedString:String
    {
        
        if !self.isValid {
            return self
        }
        if PersistanceUtil.isLanguageArabic() {
            let table = "Language_ar"
            let str = Bundle.main.localizedString(forKey: self, value: self, table: table)
            return str
        } else {
            let table = "Language_en"
            let str = Bundle.main.localizedString(forKey: self, value: self, table: table)
            return str
        }
    }
    
    var validString:String! {
        return  self
    }
    var isInValid: Bool {
        
        
        return self.validString.isEmpty
    }
    var isValid: Bool {
        
        return !self.isInValid
    }
    

    
    var isMobileNumberStartWithNonZero: Bool{
        let numbersArray = self.compactMap{Int(String($0))}
        return !(numbersArray.first == 0)
    }
    
    var isValidPassword: Bool{
        return validate(password: self)
    }
    
    func validate(password: String) -> Bool {
        var score = 0
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        if texttest.evaluate(with: password) { score = +1 }
        
        let smallLetterRegEx  = ".*[a-z]+.*"
        let texttest3 = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
        if texttest3.evaluate(with: password) {
            score = score+1
        }

        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        if texttest1.evaluate(with: password) {
            score = score+1
        }

        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        if texttest2.evaluate(with: password) {
            score = score+1
        }

        return score >= 3
    }
    
    var isValidEmail: Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
//    var isValidReferralCode: Bool{
//        let emailFormat = "[A-Z0-9a-z]*"
//        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
//        return emailPredicate.evaluate(with: self)
//    }
    
    func validMobile(minLength: Int, maxLength: Int) -> Bool {

        if minLength <= self.count && self.count <= maxLength {
            if let first = self.first, first != "0" {
                let allowedCharacters = CharacterSet(charactersIn: "0123456789").inverted
                let inputString = components(separatedBy: allowedCharacters)
                let filtered = inputString.joined(separator: "")
                return self == filtered
            }
        }
        return false
    }
    func validMobileCode(minLength: Int, maxLength: Int) -> Bool {
        if minLength <= self.count && self.count <= maxLength {
            let allowedCharacters = CharacterSet(charactersIn: "+123456789").inverted
            let inputString = components(separatedBy: allowedCharacters)
            let filtered = inputString.joined(separator: "")
            return self == filtered
        }
        return false
    }
    var isAdult: Bool {
        return Calendar.current.dateComponents([.year], from: self.dateFromFormat(.apiFormatShort)!, to: Date() ).year! >= 18
    }
    
    
    var date:Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    func dateFromFormat(_ format:DateFormats,timeZone: TimeZone? = nil) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        if let timeZone =  timeZone
        {
            dateFormatter.timeZone = timeZone
        }
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func dayFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "dd"
        let dayString = dateFormatter.string(from: date)
        return dayString
    }
    
    func weekDayFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "EEE"
        let dayString = dateFormatter.string(from: date)
        return dayString
    }
    
    func monthFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "MMM"
        let monthString = dateFormatter.string(from: date)
        return monthString
    }
    
    func dateFormatter(_ fromFormat: DateFormats = .apiFormatLong, toFormat: DateFormats) -> String {
        let dateFormatter = DateFormatter()
        let date = self.dateFromFormat(fromFormat)
        dateFormatter.dateFormat = toFormat.rawValue
        guard let postedDate = date else {return self}
        return dateFormatter.string(from: postedDate)
    }
    func dateFormatterWidget(_ fromFormat: DateFormats = .apiFormatLong, toFormat: DateFormats) -> String {
        let dateFormatter = DateFormatter()
        let date = self.dateFromFormat(fromFormat)
        dateFormatter.dateFormat = toFormat.rawValue
        dateFormatter.locale = Locale(identifier: "en_US")
        guard let postedDate = date else {return self}
        return dateFormatter.string(from: postedDate)
    }
    func dateFormatter1(_ fromFormat: DateFormats = .apiFormatShort, toFormat: DateFormats) -> String {
        let dateFormatter = DateFormatter()
        let date = self.dateFromFormat(fromFormat)
        dateFormatter.dateFormat = toFormat.rawValue
        if PersistanceUtil.isLanguageArabic()
        {
            dateFormatter.locale = Locale.init(identifier: "ar_AE")
        }
        guard let postedDate = date else {return self}
        return dateFormatter.string(from: postedDate)
    }
    func replaceDigits()
    {
        
    }
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    func dateStr(forString:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: forString)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm a"
        guard let postedDate = date else {return forString}
        return dateFormatter.string(from: postedDate)
        
    }
    
    func dateString(_ fromFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yyyy"
        guard let postedDate = date else {return self}
        return dateFormatter.string(from: postedDate)
        
    }
    
    func shortDate(forString:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: forString)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMMM d, yyyy"
        guard let postedDate = date else {return forString}
        return dateFormatter.string(from: postedDate)
    }

    func getTheEnglishNumber() -> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        let final = formatter.number(from: self)
        return final?.stringValue
    }
    
//    func strikeThrough() -> NSAttributedString {
//        if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//        {
//            return NSMutableAttributedString(string: self)
//        }
//        let attributeString =  NSMutableAttributedString(string: self)
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
//        return attributeString
//    }
    
    func amountFormat() -> String{
          let formatter = NumberFormatter()
          formatter.maximumFractionDigits = 0
          formatter.numberStyle = .decimal
          let result = formatter.string(from: NSNumber(value: Int(self) ?? 0))
          return result ?? ""
      }
    
    
}


extension String {
     func getHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

     func getWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
