//
//  NetworkConnection.swift

//

import UIKit
import Alamofire

class NetworkConnection {
    static let shared = NetworkConnection()
    let reachabilityManager: NetworkReachabilityManager?
    private init() {
        reachabilityManager = NetworkReachabilityManager()
    }
    var isConnected: Bool {
        if let reachability = reachabilityManager, reachability.isReachable {
            return true
        } else {
            return false
        }
    }
}
