//
//  UploadManager.swift

//

import Foundation
import Alamofire
import Reachability
import SwiftyJSON
class UploadManager {
    
    class func uploadProfileImage (url:String!, image:UIImage?, needUserToken:Bool, completion:@escaping (APIResponse) -> Void)
    {
        
        if let image = image {
            var compression = 0.9
            let maxCompression = 0.01
            let maxFileSize = (0.5*1024*1024);
            let orientationFixedImage = image.normalizedImage()
            var imgData:Data = orientationFixedImage.jpegData(compressionQuality: CGFloat(compression))!
            
            compression = Double(Double(maxFileSize)/Double(imgData.count));
            
            if(compression>0.9)
            {
                compression = 0.9;
            }
            if(compression<maxCompression)
            {
                compression = maxCompression;
            }
            
            imgData = orientationFixedImage.jpegData(compressionQuality: CGFloat(compression))!;
            uploadData(url: url, data: imgData, name: "image", fileName:"image.jpg", mimeType: "image/jpeg", needUserToken: needUserToken, completion: completion)
        }
        
    }
    
    class func uploadData (url:String!, data:Data?, name:String, fileName:String, mimeType:String, needUserToken:Bool, completion:@escaping (APIResponse) -> Void) {
        
        guard let data = data else
        {
            completion(APIResponse.createFailureAPIResponse(MessageConstant.noData.localizedString))
            return
        }
//        guard AppManager.shared.hasNetwork() else {
//            completion(APIResponse.createFailureAPIResponse(MessageConstant.noNetwork))
//
//            return
//        }
        
        let userToken =  AppManager.shared.token.isEmpty ?  APIContants.token : AppManager.shared.token
        
        var language = String()
        if Organizer.shared.appLanguage == .arabic {
            language = "ar"
        } else {
            language = "en"
        }
        
        let headers: HTTPHeaders = [
            "Authorization": userToken,
            "content-type": "application/json",
            "language": language,
        ]
        let absoluteUrl = AppConfig.shared.apiEndpoint + url
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: name, fileName: fileName, mimeType: mimeType)
            
        }, to: absoluteUrl, headers: headers).uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }.responseJSON { (response) in
            switch response.result{
            case .success( _):
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        if let result = response.value {
                            let resultDictionary = result as! [String : Any]
                            let resultJSON = JSON(resultDictionary)
                            Logger.logResponseParams(key: "Response", value: resultDictionary)
                            let code = resultJSON["response_code"].intValue
                            let message = resultJSON["message"].stringValue
                            
                            if(code == APIContants.successCode) {
                                DispatchQueue.main.async {
                                    
                                    
                                    completion(APIResponse.createSuccessAPIResponse(message,resultJSON))
                                }
                            }
                            else if(code == APIContants.unauthenticated) {
                                DispatchQueue.main.async {
                                    completion(APIResponse.createFailureAPIResponse(message, resultJSON))
                                    //                                                        AppDelegate.appdelegate.logout()
                                }
                            }
                            else
                            {
                                DispatchQueue.main.async {
                                    completion(APIResponse.createFailureAPIResponse(message, resultJSON))
                                }
                            }
                            
                        }
                        
                    default:
                        
                        DispatchQueue.main.async {
                            completion(APIResponse.createFailureAPIResponse(MessageConstant.someError))
                            
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        completion(APIResponse.createFailureAPIResponse(MessageConstant.someError))
                    }
                    
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(APIResponse.createFailureAPIResponse(MessageConstant.someError))
                }
            }
        }
        
    }

}
