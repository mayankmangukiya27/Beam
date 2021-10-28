//
//  NotificationCenter+Extension.swift

//

import Foundation

extension Notification.Name {
    static let userTokenUpdated = Notification.Name(rawValue: "userTokenUpdated")
    static let productAttributesUpdated = Notification.Name(rawValue: "productAttributesUpdated")
    static let bannersFetched = Notification.Name(rawValue: "bannersFetched")
    static let paymentComplete = Notification.Name(rawValue: "paymentComplete")

    static let userCartUpdated = Notification.Name(rawValue: "userCartUpdated")
    static let notificationTapped = Notification.Name(rawValue: "notificationTapped")

}
