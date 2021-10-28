//
//  BottomSheetVC.swift


import UIKit
import FloatingPanel
protocol BottomSheetProtocol:UIViewController
{
    func didSelectItems(_ vc:BottomSheetVC, items:[SelectableItem]) -> Void
    func didCompleteActions(_ vc:BottomSheetVC) -> Void

}
class BottomSheetVC: UIViewController {
    
    weak var delegate:BottomSheetProtocol?
    var floatingPanelLayout:FloatingPanelLayout?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppColor.white
        self.view.cornerRadiusValue = 20
        self.view.clipsToBounds = true
    }
}
protocol SelectableItem
{
    var hashableId:AnyHashable{get}
    var hashableName:AnyHashable{get}
}


class MyFloatingPanelLayout: FloatingPanelLayout {
    static var tipNormal:CGFloat = 16.0
    static var halfNormal:CGFloat = 216.0
    static var fullNormal:CGFloat = 44.0

    var initialPosition: FloatingPanelPosition  = .full
    var supportedPositions: Set<FloatingPanelPosition> = [.full]
    var positions:[CGFloat] =  [tipNormal, halfNormal, fullNormal]
    var shouldFitContent =  false

    init(supportedPositions:Set<FloatingPanelPosition>,initialPosition:FloatingPanelPosition, positions:[CGFloat]? = nil, shouldFitContent:Bool = false)
       {
        self.supportedPositions = supportedPositions
        self.initialPosition = initialPosition
        if let positions = positions, positions.count == 3
        {
           self.positions = positions
        }
        self.shouldFitContent = shouldFitContent
       }
     

       public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
           switch position {
           case .full: return shouldFitContent ? nil : positions[0] // A top inset from safe area
               case .half: return positions[1]// A bottom inset from the safe area
           case .tip: return positions[2] // A bottom inset from the safe area
               default: return nil // Or `case .hidden: return nil`
           }
       }
   }

class MyFloatingPanelFitLayout: FloatingPanelIntrinsicLayout {
    static var tipNormal:CGFloat = 30.0
    static var halfNormal:CGFloat = 216.0
    static var fullNormal:CGFloat = 20.0
    
    var initialPosition: FloatingPanelPosition  = .full
    var supportedPositions: Set<FloatingPanelPosition> = [.full]
    var positions:[CGFloat] =  [tipNormal, halfNormal, fullNormal]
    var shouldFitContent =  false
    
    init(supportedPositions:Set<FloatingPanelPosition>,initialPosition:FloatingPanelPosition, positions:[CGFloat]? = nil, shouldFitContent:Bool = false)
    {
        self.supportedPositions = supportedPositions
        self.initialPosition = initialPosition
        if let positions = positions, positions.count == 3
        {
            self.positions = positions
        }
        self.shouldFitContent = shouldFitContent
    }
    
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return nil// A top inset from safe area
        case .half: return positions[1]// A bottom inset from the safe area
        case .tip: return positions[2] // A bottom inset from the safe area
        default: return nil // Or `case .hidden: return nil`
        }
    }
}
