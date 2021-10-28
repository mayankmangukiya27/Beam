//
//  Common+Extension.swift

//

import Foundation
import CoreGraphics
import UIKit

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)//
   //    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

}
protocol DoubleValueProtocol {
    func getDoubleValue() -> Double
}
let random = Int.random(in: 1...100000)

extension Int
{
    func hoursMinutesSeconds ()-> (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
    func componentsValue ()-> String{
        
        
        let (h,m,s) = self.hoursMinutesSeconds()
        var components = [String]()
        if h > 0
        {
            let  hours = String(h) + " " + "Hours"
            components.append(hours)
            
        }
        if m > 0
        {
            let mins = String(m) + " " + "Mins"
            components.append(mins)
        }
        
        let seconds = String(s) + " " + "Sec"
        components.append(seconds)
        
        return components.joined(separator: " ")
        
    }
}

extension Double: DoubleValueProtocol {
    func getDoubleValue() -> Double {
        return self
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float: DoubleValueProtocol {
    func getDoubleValue() -> Double {
        return Double(self)
    }
}

extension String: DoubleValueProtocol {
    func getDoubleValue() -> Double {
        return Double(self) ?? 0.0
    }
}

extension Swift.Optional: DoubleValueProtocol {
    func getDoubleValue() -> Double {
        switch self {
        case .some(let value):
            return Double(String(describing: value)) ?? 0.0
        case _:
            return 0.0
        }
    }
}

extension CGFloat{
    func aspectRatioHeight() -> CGFloat{
        return (self*400)/640
    }
    
    func adsAspectRatioHeight() -> CGFloat{
        return (self*80)/370
    }
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: UIFont.AppFont.regular, size: 14)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
extension UITableView {

    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }

    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            guard numberOfSections > 0 else { return }
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}
extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: UIFont.AppFont.regular, size: 14)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
