//
//  AppConfig.swift

//

import Foundation

class AppConfig {
    static var shared = AppConfig()
    var infoList = [String: Any]()
    var apiDomain: String = ""
    var apiEndpoint: String = ""
    private init() {
        if let info = Bundle.main.infoDictionary {
            infoList = info
        }
        if let rootDomain = infoList["ROOT_DOMAIN"] as? String, let rootEndPoint = infoList["ROOT_API_URL"] as? String {
            apiDomain = rootDomain
            apiEndpoint = rootEndPoint
        } else {
            fatalError("Config file missing or error while loading config")
        }
    }

}

