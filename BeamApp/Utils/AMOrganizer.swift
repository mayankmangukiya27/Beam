//
//  AMOrganizer.swift

//

import Foundation
import UIKit

enum AppLanguage: Int {
    case arabic, english
    var stringValue: String {
        switch self {
        case .english:
            return "English"
        case .arabic:
            return "Arabic"
        }
    }
    static var defaultLanguage: AppLanguage {
        return AppLanguage.english
    }
}
enum DisplayMode: Int {
    case light, dark
    var stringValue: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        }
    }
    static var defaultMode: DisplayMode {
        return DisplayMode.dark
    }
}
class Organizer {
    static let shared = Organizer()
    
    private var _appLanguage: AppLanguage?
    var appLanguage: AppLanguage {
        get {
            if _appLanguage == nil {
                if let languageValue = AppUserDefaults.getSavedObject(forKey: .languageKey) as? Int, let language = AppLanguage(rawValue: languageValue) {
                    _appLanguage = language
                } else {
                    AppUserDefaults.saveObject(AppLanguage.defaultLanguage.rawValue, forKey: .languageKey)
                    _appLanguage = AppLanguage.defaultLanguage
                }
            }
            return _appLanguage ?? AppLanguage.defaultLanguage
        }
        set(language) {
            _appLanguage = language
            AppUserDefaults.saveObject(language.rawValue, forKey: .languageKey)
        }
    }
    
    var deviceToken: String? {
        get {
            let registeredToken =  AppUserDefaults.getSavedObject(forKey: .deviceTokenKey) as? String
            return registeredToken
        }
        set(token) {
            AppUserDefaults.saveObject(token, forKey: .deviceTokenKey)
        }
    }
    private var _appMode: DisplayMode?
    var appMode: DisplayMode {
        get {
            if _appMode == nil {
                if let displayValue = AppUserDefaults.getSavedObject(forKey: .displayMode) as? Int, let language = DisplayMode(rawValue: displayValue) {
                    _appMode = language
                } else {
                    AppUserDefaults.saveObject(DisplayMode.defaultMode.rawValue, forKey: .languageKey)
                    _appMode = DisplayMode.defaultMode
                }
            }
            return _appMode ?? DisplayMode.defaultMode
        }
        set(language) {
            _appMode = language
            AppUserDefaults.saveObject(language.rawValue, forKey: .displayMode)
        }
    }
    
    
    var selectedSeasonId: String {
        get {
           let value = AppUserDefaults.getSavedObject(forKey: .selectedSeasonKey) as? String
            return value ?? ""
        }
        set(seasonId) {
            AppUserDefaults.saveObject(seasonId, forKey: .selectedSeasonKey)
        }
    }

    var selectedCompetitionId: String {
        get {
           let value = AppUserDefaults.getSavedObject(forKey: .selectedCompetitionKey) as? String
            return value ?? ""
        }
        set(seasonId) {
            AppUserDefaults.saveObject(seasonId, forKey: .selectedCompetitionKey)
        }
    }
    
    var activeCompetitionid: String {
        get {
           let value = AppUserDefaults.getSavedObject(forKey: .activeCompetitionid) as? String
            return value ?? ""
        }
        set(seasonId) {
            AppUserDefaults.saveObject(seasonId, forKey: .activeCompetitionid)
        }
    }
    
    var activeWeekNumber: Int {
        get {
           let value = AppUserDefaults.getSavedObject(forKey: .activeWeekNumber) as? Int
            return value ?? 0
        }
        set(seasonId) {
            AppUserDefaults.saveObject(seasonId, forKey: .activeWeekNumber)
        }
    }

    
    
}
enum UserDefaultsConstant: String {
    case languageKey = "languageValue"
    case displayMode = "displayValue"
    case deviceTokenKey = "deviceTokenValue"
    case selectedSeasonKey = "selectedSeasonValue"
    case selectedCompetitionKey = "selectedCompetitionValue"
    case activeCompetitionid = "activeCompetitionid"
    case activeWeekNumber = "activeWeekNumber"
}

class AppUserDefaults {
    class func saveObject(_ object: Any?, forKey key: UserDefaultsConstant) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key.rawValue)
        defaults.synchronize()
    }

    class func getSavedObject(forKey: UserDefaultsConstant) -> Any? {
        let savedObject = UserDefaults.standard.object(forKey: forKey.rawValue)
        return savedObject
    }
}
