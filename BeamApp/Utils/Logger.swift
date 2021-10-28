//
//  Logger.swift

//

import UIKit
import SwiftyJSON
import Alamofire

class Logger {


    static func log(key:String,value:Any)
    {
        print("\(key):\(value)")
    }
    
    static func logString(key:String, value:String)
    {
       //    NSLog("%@:%@", key,value)
    }
    
    static func logRequestParams(key:String, value:[String:Any])
    {
        
//           NSLog("%@:%@", key,Utils.getJsonText(parameters: value))
    }
    static func logResponseParams(key:String, value:[String:Any])
    {
        logResponseParams(key: key, value: JSON(value))
        
//           NSLog("%@:%@", key,Utils.getJsonText(parameters: value))
    }
    static func logTripUpdates(key:String, value:[String:Any])
    {
        let  string = Utils.getJsonText(parameters: value)
        
        log(key: key, value: string)

        //           NSLog("%@:%@", key,Utils.getJsonText(parameters: value))
    }
    static func logRequestParams(key:String,url:String,header:HTTPHeaders, value:[String:Any])
    {
        let  string = NSString.init(format: "%@: %@ %@ %@", key,url,Utils.getJsonText(parameters: header.dictionary), Utils.getJsonText(parameters: value))
        //        NSLog("%@: %@ %@ %@", key,url,Utils.getJsonText(parameters: header), Utils.getJsonText(parameters: value))
             print(string)
//
    }
    static func logResponseParams(key:String, value:JSON)
    {
        let  string = NSString.init(format: "%@:%@", key,(value.rawString() ?? ""))
         
            print(string)
        
    }
   
}
