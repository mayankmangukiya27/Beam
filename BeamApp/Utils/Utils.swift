//
//  Utils.swift

//

import UIKit
import MapKit
import Photos
import SafariServices
import AVFoundation
import AVKit
import WebKit
//import YoutubeDirectLinkExtractor
class Utils: NSObject {
    static var displayWidth:CGFloat {
           let screenSize = UIScreen.main.bounds
           let screenWidth = screenSize.width
           return screenWidth
       }
       
       class func getJsonText(parameters:[String:Any]) -> String {
           var  theJSONText = ""
           if let theJSONData = try? JSONSerialization.data(
               withJSONObject: parameters,
               options: []) {
               theJSONText = String(data: theJSONData,
                                    encoding: .ascii) ?? ""
           }
           return theJSONText
       }
      

       class func callNumber(phoneNumber:String) {
         if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

           let application:UIApplication = UIApplication.shared
           if (application.canOpenURL(phoneCallURL)) {
               application.open(phoneCallURL, options: [:], completionHandler: nil)
           }
         }
       }
       
       class func mailTo(email:String) {
           if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                  UIApplication.shared.open(url)
                } else {
                  UIApplication.shared.openURL(url)
                }
              }
       }
       
       class func openMapForPlace(latitude:Double,longitude:Double,name:String) {

           let regionDistance:CLLocationDistance = 10000
           let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
           let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
           let options = [
               MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
               MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
           ]
           let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
           let mapItem = MKMapItem(placemark: placemark)
           mapItem.name = name
           mapItem.openInMaps(launchOptions: options)
       }
    
    static func canOpenGoogleMaps() -> Bool {
    return (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!))
    }
    
    static func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
    
    static func openGoogleAppWithpoints(startpoints: [CLLocationCoordinate2D], endpoints: [CLLocationCoordinate2D], vc: UIViewController) {
        if Utils.canOpenGoogleMaps() {
            let startlocation = startpoints[0]
            let googleMapURL = "comgooglemaps://?daddr=\(startlocation.latitude),\(startlocation.longitude)&directionsmode=driving"
            UIApplication.shared.open(URL(string: googleMapURL)!)
        } else {
            vc.showErrorMessage(message: "Google Maps application not installed".localizedString)
        }
    }
    
    class func openLoginInvitePopup(in controller:UIViewController){
        let alertController = UIAlertController(title: "Please login to the app".localizedString, message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Login".localizedString, style: UIAlertAction.Style.default) {
            UIAlertAction in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel".localizedString, style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
       
    class func versionString() ->  String{
        var versionString: String = ""
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionString = version as String
        }
        return versionString as String
    }
           
    class func buildNumber() ->  Int? {
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return Int(version)
        }
        return nil
    }
    class func printFonts()
    {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            if family.lowercased().contains("bukra") || family.lowercased().contains("cairo")
            {
                print("Family: \(family) Font names: \(names)")

            }
        }
    }
        
    class func removeLayerWithName(name:String, fromView view:UIView){
        view.layer.sublayers?.forEach({
            if let layer = $0 as? CAShapeLayer, layer.name == name{
                layer.removeFromSuperlayer()
            }
        })
    }
    
    
    
    class func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    
    class func getMediaDuration(url: URL) -> Double {
        let asset : AVURLAsset = AVURLAsset(url: url) as AVURLAsset
        let duration : CMTime = asset.duration
        return CMTimeGetSeconds(duration)
    }
    
    class func isYoutubeLink(strUrl checkString: String) -> Bool {
        
        let youtubeRegex = "(http(s)?:\\/\\/)?(www\\.|m\\.)?youtu(be\\.com|\\.be)(\\/watch\\?([&=a-z]{0,})(v=[\\d\\w]{1,}).+|\\/[\\d\\w]{1,})"
        
        let youtubeCheckResult = NSPredicate(format: "SELF MATCHES %@", youtubeRegex)
        return youtubeCheckResult.evaluate(with: checkString)
    }
}


let statusBarHeight = UIApplication.shared.statusBarFrame.height
func generateThumbnail(path: URL) -> UIImage? {
    do {
        let asset = AVURLAsset(url: path, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
        let thumbnail = UIImage(cgImage: cgImage)
        return thumbnail
    } catch let error {
        print("*** Error generating thumbnail: \(error.localizedDescription)")
        return nil
    }
}
func loadVideo(fromURL str:String, controller:UIViewController){
        guard let urlMain = URL(string: str) else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: urlMain)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let cv = AVPlayerViewController()
        cv.player = player
        
        // Modally present the player and call the player's play() method when complete.
        controller.present(cv, animated: true) {
            player.play()
            
        }
    }
    
    

func convertToDictionary(text: String) -> [[String: Any]]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
