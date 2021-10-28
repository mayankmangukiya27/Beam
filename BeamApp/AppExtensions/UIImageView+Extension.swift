//
//  UIImage+Extension.swift

//

import UIKit
import Kingfisher
extension UIImageView {
    
    func loadFromUrlString(_ urlString:String?, placeholder:Placeholder? = nil, needAccess:Bool = true, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        if (urlString == nil || urlString?.isEmpty ?? false) {
            self.image = #imageLiteral(resourceName: "placeholder")
            return
        }
       
        
        let urStr = urlString?.replacingOccurrences(of: "|", with: "%7c")
        guard let urString = urStr else {return}
        let url = URL(string: urString)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholder, completionHandler: completionHandler)

    }
}
