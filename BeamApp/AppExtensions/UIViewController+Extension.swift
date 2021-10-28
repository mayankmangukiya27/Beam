//
//  UIViewController+Extension.swift
//

import Foundation
import NVActivityIndicatorView
import SwiftyJSON
import SnapKit
import AVFoundation
import AVKit

extension UITableViewCell
{
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
extension UIViewController
{
    
   
    
    
    class func fromNib<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        return T(nibName: name, bundle: Bundle.main)
    }
    
    
    @objc func injected() { //2
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        if let sublayers = self.view.layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
        loadView()
        viewDidLoad()
    }
    
    func startActivityIndicator() {
        
        DispatchQueue.main.async {
            NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleMultiple
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.black
            NVActivityIndicatorView.DEFAULT_PADDING = 10
            
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData,nil)
            
        }
        
        
    }
   
    func stopActivityIndicator() {
        
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    func ciruclarImage() -> UIImageView
    {
        let rect = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        let imageView = UIImageView.init(frame: rect)
        imageView.backgroundColor = UIColor.clear
        imageView.image =  UIImage.init(named: "Spinner")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let rotation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber.init(value:  Float.pi * 2.0  * 1 * 2)
        rotation.duration = 2
        rotation.repeatCount = Float.infinity;
        imageView.layer.add(rotation, forKey: "rotationAnimation")
        return imageView
        
        
    }
    
    func showVersionUpdate(urlString: String, message:String) {
        
        //            let childVC = ForceUpdateVC()
        //            childVC.urlString = urlString
        //            removeChildVCs()
        //            self.addChild(childVC)
        //            childVC.view.frame = UIScreen.main.bounds
        //            AppDelegate.appdelegate.window?.addSubview(childVC.view)
        //            childVC.didMove(toParent: self)
    }
    
    func showInViewController(vc:UIViewController) {
        
        vc.addChild(self)
        self.view.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.view.alpha = 1.0
                       }, completion: nil)
        vc.view.addSubview(self.view)
    }
    func dismissFromViewController() {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func addChildVC(childVC:UIViewController,containerView:UIView, withAnimation:Bool = false) {
        removeChildVCs()
        self.addChild(childVC)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        childVC.view.autoresizingMask = []
        if withAnimation {
            childVC.view.alpha = 0
            containerView.addSubview(childVC.view)
            childVC.view.snp.makeConstraints { (make) -> Void in
                make.edges.equalToSuperview()
            }
            childVC.didMove(toParent: self)
            UIView.animate(withDuration: 0.5) {
                childVC.view.alpha = 1
            }
//            UIView.transition(with: containerView, duration: 0.5, options: UIView.AnimationOptions.curveEaseIn) {
//                containerView.addSubview(childVC.view)
//            } completion: { anim in
//                childVC.view.snp.makeConstraints { (make) -> Void in
//                    make.edges.equalToSuperview()
//                }
//                childVC.didMove(toParent: self)
//            }

        } else {
            containerView.addSubview(childVC.view)
            childVC.view.snp.makeConstraints { (make) -> Void in
                make.edges.equalToSuperview()
            }
            childVC.didMove(toParent: self)
        }
        
    }
    
    func removeChildVCs() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        
    }
    
    func openMailApp(toEmail: String) {
        let email = toEmail
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func openCallApp(phoneNumber:String) {
        
        let number = phoneNumber
        if let url = URL(string: "telprompt:\(number)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func openSocialAccount(appUrl:String, browserUrl:String){
        let browser = URL(string: browserUrl)
        let appURL = URL(string: appUrl)
        let application = UIApplication.shared
        if let url = appURL, application.canOpenURL(url)
        {
            application.open(url)
        }
        else if let url = browser
        {
            application.open(url)
        }
    }
    
    func failureBlock() -> APICompletionBlock {
        return { (response) in
            self.stopActivityIndicator()
            if response.message.lowercased().contains("there is no data")
            {
                print("error")
            }
            self.showErrorMessage(message: response.message)
        }
    }
    
    
    func showErrorMessage(message : String?) {
        //        CRNotifications.showNotification(type: .error, title: "".localizedString, message: message ?? "", dismissDelay: 2)
        let alert = UIAlertController(title: "".localizedString, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay".localizedString, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
        func showSuccessMessage(message : String?) {
       //     CRNotifications.showNotification(type: .success, title: "", message: message ?? "", dismissDelay: 2)
        }
    //
        func showInfoMessage(title : String?, message : String?) {
            let localizedMessage = message?.localizedString
         //   CRNotifications.showNotification(type: .info, title: title ?? "", message: localizedMessage ?? "", dismissDelay: 2)
        }
    var isModalStyle: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    func currentLocalDateTime() -> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.displayFormat.rawValue
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
}
