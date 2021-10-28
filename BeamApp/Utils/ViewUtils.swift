//
//  ViewUtils.swift

//

import UIKit

struct ViewUtils {
    static func righBarButtonItem(title:String,target:Any?,action:Selector?) -> UIBarButtonItem
    {
        let button = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
               button.setTitleTextAttributes([
                   NSAttributedString.Key.font : UIFont(name: UIFont.AppFont.regular, size: 16)!,
                   NSAttributedString.Key.foregroundColor : UIColor.AppColor.white],
                                             for: .normal)
        return button
    }
}
