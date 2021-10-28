//
//  Date+Extension.swift

//

import Foundation

extension Date {
    
    var daysInMonth:Int{
        let calendar = Calendar.current
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
    func Year() -> Int {
        let year = Calendar.current.component(.year, from: self)
        return year
    }
    var startOfDay: Date {
        return Calendar(identifier: .gregorian).startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfDay)!
    }
    func toDotString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let identifier = Organizer.shared.appLanguage == .english ? "en_US" : "ar_AE"
        dateFormatter.locale = Locale(identifier: identifier)
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let identifier = Organizer.shared.appLanguage == .english ? "en_US" : "ar_AE"
        dateFormatter.locale = Locale(identifier: identifier)
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    func toDayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM yyyy"
        let identifier = Organizer.shared.appLanguage == .english ? "en_US" : "ar_AE"
        dateFormatter.locale = Locale(identifier: identifier)
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    
    func displayStringForFormat(_ format:DateFormats,timeZone:TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        if let timeZone = timeZone
        {
            dateFormatter.timeZone = timeZone

        }
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func localisedStringForFormat(_ format:DateFormats) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "ar_AE")
        return dateFormatter.string(from: self)
    }

    var remainingTimeSinceNow: String {
        return getRemainingTimeSinceNow()
    }
    
    private func getRemainingTimeSinceNow() -> String {
        
        var interval = 0

        
        interval = Calendar.current.dateComponents([.day], from: Date(), to: self).day!
        if interval > 0 {
            return interval == 1 ? "\(interval) " + "day".localizedString : "\(interval) " + "days".localizedString
        }
        
        interval = Calendar.current.dateComponents([.hour], from: Date(), to: self).hour!
        if interval > 0 {
            return interval == 1 ? "\(interval) " + "hour".localizedString : "\(interval) " + "hours".localizedString
        }
        
        interval = Calendar.current.dateComponents([.minute], from: Date(), to: self).minute!
        if interval > 0 {
            return interval == 1 ? "\(interval) " + "minute".localizedString : "\(interval) " + "minutes".localizedString
        }
        
        return "a minute"
    }
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
  
}

func getDateWith(date: String,inputFormat: String,outputFormat:DateFormats) -> String{
    if !date.isValid{
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat
    let dt = dateFormatter.date(from: date)
    dateFormatter.dateFormat = outputFormat.rawValue
    return dateFormatter.string(from: dt!)
}
func getDateFromString(date: String,inputFormat: String) -> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat
    let dt = dateFormatter.date(from: date)
    return dt
    
}
func getStringFromDate(date: Date,inputFormat: String) -> String?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat
    let dt = dateFormatter.string(from: date)
    return dt
    
}
