//
//  TapFilter.swift

//

import Foundation
import UIKit
class TapFilter: UIView {

    var touchThroughs: [UIView]?

    var didTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let touchThroughs = touchThroughs {
            for view in touchThroughs {
                if view.point(inside: self.convert(point, to: view), with: event) {
                    return false
                }
            }
            return true
        }
        return super.point(inside: point, with: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTap?()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { }
}
