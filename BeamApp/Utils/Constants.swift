//
//  Constants.swift

//

import Foundation

enum DateFormats:String {
    case apiFormatShort = "yyyy-MM-dd"
    case apiFormatLong = "yyyy-MM-dd HH:mm:ss"
    case apiFormatStandard = "yyyy/MM/dd"
    case displayFormat = "dd MMMM yyyy"
    case displayFormatShort = "dd MMM yyyy"
    case displayFormatWeek = "EEEE dd MMMM yyyy"
    case displayFormatWeekWithComma = "EEEE dd MMMM, yyyy"
    case displayFormatWithTime = "dd MMM yyyy, HH:mm"
    case displayFormatStandard = "dd/MM/yyyy"
    case time = "HH:mm"
    case time12 = "hh:mm a"
    case shortestDate = "dd/MM"
    case displayFormatWeekShortName = "EEE dd/MM/yyyy"
    case monthYear = "MMMM yyyy"
}

enum APIEndPoint: String {
    case login = "user-login"
    case register = "user-registers"
    case countryList = "country-listing"
    case userHome = "user-home-api"
    case userData = "user-data"
    case fetchBrandverticalDetail = "vertical-details"
    case fetchBrandDetails = "brand-details"
    case followUnfollow = "update-favorite"
    case updateProfile = "user-update"
    case versionupdate = "version-update"
    case guestHome = "guest-home-api"
    case faq = "faq"
    case tAndC = "terms-conditions"
    case privacyPolicy = "privacy-policy"
    case profileInterestList = "lists-interests"
    case profilePic = "update-picture"
    case homeScreen = "home-screen"
    case categoryList = "list-verticals"
    case forgotPassword = "forgot-password"
    case changePassword = "change-password"
    case myFavorites = "my-favorite-list"
    case eventList = "event-lists"
    case eventDetail = "event-details"
    case contactUs = "save-contact"
    case newsList = "news-lists"
    case saveInterest = "save-interests"
    case saveItem = "save-useritem"
    case savedItems = "save-useritem-list"
}

struct APIContants {
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9eyJzdWIiOiIxMj"
    static let successCode = 2000
    static let errorCode = 3000
    static let unauthenticated = 30000
    static let tokenExpire = 5000
}


struct MessageConstant {
    static let noNetwork = "No network connection".localizedString
    static let someError = "Some error occured".localizedString
    static let noData = "There is no content to be displayed"
    static let sslPinningError = "SSL Pinning Error found."

}

extension Notification.Name {
    static let userTokenDataUpdated = Notification.Name(rawValue: "userTokenUpdated")
    static let userDataUpdated = Notification.Name(rawValue: "userDataUpdated")
    static let myFollowingTapped = Notification.Name(rawValue: "myFollowingTapped")
    static let newsTapped = Notification.Name(rawValue: "newsTapped")
    static let eventTapped = Notification.Name(rawValue: "eventTapped")
    static let searchTapped = Notification.Name(rawValue: "searchTapped")
    static let savedItemsTapped = Notification.Name(rawValue: "savedItemsTapped")
    static let offersTapped = Notification.Name(rawValue: "offersTapped")
}
