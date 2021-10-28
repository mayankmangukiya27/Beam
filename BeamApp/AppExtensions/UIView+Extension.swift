//
//  UIView+Extension.swift

//

import UIKit
public enum ViewPoint {
    case none
    case topLeft
    case topRight
    case bottomRight
    case bottomLeft
    case centre

}
@IBDesignable extension UIView
{
 
    @IBInspectable public var isFlippable:Bool
    {
        get {
            return  Organizer.shared.appLanguage == .arabic
        }
        set {
            if(newValue)
            {
                self.flipHorizontal()
            }
            
        }
    }
    
    @IBInspectable public var shadowEnabled: Bool {
        get {
            return layer.shadowRadius > 0
        }
        set {
            if(newValue)
            {
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowRadius = 4.0
                self.layer.shadowOpacity = 0.5
                self.layer.shadowOffset = CGSize(width:0,height:0)
                self.layer.masksToBounds = false
            }
            else
            {
                self.layer.shadowColor = UIColor.clear.cgColor
                self.layer.shadowRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowOffset = CGSize(width:0,height:0)

            }
           
        }
    }
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor =  UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 5
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }
    
    func drawDottedLine() {
        let p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        let p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func dropSmallShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor =  UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 2
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }
    
    func shadows() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 7
       layer.cornerRadius = 10
    }

    func addGradient(withColors colors:[UIColor]){
        for lay in self.layer.sublayers ?? []{
            if lay.name == "gradient"{
                lay.removeFromSuperlayer()
            }
        }
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = colors
        gradient.name = "gradient"
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
       
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        self.layer.insertSublayer(gradient, at: 0)
    }
    @IBInspectable public var bgColorPrimary:Bool
        {
        get {
            return  self.backgroundColor == UIColor.AppColor.primary
        }
        set {
            if(newValue)
            {
            self.backgroundColor = UIColor.AppColor.primary
            }
        }
    }
    
    @IBInspectable public var bgColorHighlight:Bool
        {
        get {
            return  self.backgroundColor == UIColor.AppColor.primary
        }
        set {
            if(newValue)
            {
                self.backgroundColor = UIColor.AppColor.primary
            }
            
        }
    }
    @IBInspectable public var bgColorAccent:Bool
        {
        get {
            return  self.backgroundColor == UIColor.AppColor.accent
        }
        set {
            if(newValue)
            {
                self.backgroundColor = UIColor.AppColor.accent
            }
            
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var cornerRadiusValue: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
//    @IBInspectable public var bgColorAccentSec:Bool
//        {
//        get {
//            return  self.backgroundColor == UIColor.AppColor.accentSec
//        }
//        set {
//            if(newValue)
//            {
//                self.backgroundColor = UIColor.AppColor.accentSec
//            }
//
//        }
//    }
    
    
//    @IBInspectable public var bgColorAccentThird:Bool
//        {
//        get {
//            return  self.backgroundColor == UIColor.AppColor.accentSec
//        }
//        set {
//            if(newValue)
//            {
//                self.backgroundColor = UIColor.AppColor.accentSec
//            }
//            
//        }
//    }
    
    @IBInspectable public var addBottomCornerRedius: CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
               self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        }
    }
    func flipHorizontal() {
        if Organizer.shared.appLanguage == .arabic {
            transform = CGAffineTransform(scaleX: -1, y: 1)
        } else {
            transform = CGAffineTransform.identity
        }
    }
    @IBInspectable var shadowWithCornerRadius: Bool {
        get {
            return layer.shadowRadius > 0
        }
        set {
            if (newValue) {
                let shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusValue).cgPath
                shadowLayer.fillColor = UIColor.white.cgColor
                
                shadowLayer.shadowColor = UIColor.darkGray.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                shadowLayer.shadowOpacity = 0.8
                shadowLayer.shadowRadius = 2
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        }
    }
    var frameWidth:CGFloat
    {
        get {
            return self.frame.size.width
        }
        set(newValue)
        {
             self.frame.size.width =  newValue

        }

    }
    var frameHeight:CGFloat
    {
        get {
            return self.frame.size.height
        }
        set(newValue)
        {
             self.frame.size.height =  newValue

        }

    }
    var halfWidth:CGFloat
    {
        return self.frameWidth / 2

    }
    var halfHeight:CGFloat
    {
        return self.frameHeight / 2

    }
    
    var topLeft:CGPoint
    {
        get {
            return self.frame.origin
        }
        set(newValue)
        {
            self.frame.origin =  newValue
            
        }

    }
    var topRight:CGPoint
    {
        get {
            return CGPoint.init(x: self.topLeft.x + self.frameWidth , y: self.topLeft.y)
        }
        set(newValue)
        {
            self.topLeft = CGPoint.init(x: newValue.x - self.frameWidth , y: newValue.y)
            
        }
        
    }
    var bottomLeft:CGPoint
    {
        get {
            return CGPoint.init(x: self.topLeft.x , y: self.topLeft.y + self.frameHeight)
        }
        set(newValue)
        {
            self.topLeft = CGPoint.init(x: newValue.x , y: newValue.y - self.frameHeight)
            
        }
        
    }
    var bottomRight:CGPoint
    {
        get {
            return CGPoint.init(x: self.bottomLeft.x + self.frameWidth , y: self.bottomLeft.y)
        }
        set(newValue)
        {
            self.topLeft = CGPoint.init(x: newValue.x  - self.frameWidth , y: newValue.y - self.frameHeight)
            
        }
        
    }
    func alignToView(view:UIView, viewPoint:ViewPoint, offset:CGSize)
    {
        var centerPoint = CGPoint.zero
        
        switch viewPoint {
        case .topLeft:
            centerPoint = CGPoint.init(x: view.topLeft.x + offset.width, y: view.topLeft.y + offset.height)
            break
        case .topRight:
            centerPoint = CGPoint.init(x: view.topRight.x + offset.width, y: view.topRight.y + offset.height)
            break
        case .bottomLeft:
            centerPoint = CGPoint.init(x: view.bottomLeft.x + offset.width, y: view.bottomLeft.y + offset.height)
            break
        case .bottomRight:
            centerPoint = CGPoint.init(x: view.bottomRight.x + offset.width, y: view.bottomRight.y + offset.height)
            break
        default:
            centerPoint = CGPoint.zero
            break
        }
        self.center = centerPoint
    }
    
    func alignToView(view:UIView, viewPoint:ViewPoint)
    {
        let offset = CGSize.init(width: self.halfWidth, height: self.halfHeight)
        self.alignToView(view: view, viewPoint: viewPoint, offset: offset)
    }
    func alignToCornerOfView(view:UIView, viewPoint:ViewPoint)
    {
        let offset = CGSize.zero
        self.alignToView(view: view, viewPoint: viewPoint, offset: offset)
    }
    
    func setAnchorPoint(anchorPoint: CGPoint) {
        var newPoint = CGPoint.init(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        
        var oldPoint = CGPoint.init(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)

        
        newPoint = newPoint.applying(self.transform)
        oldPoint = oldPoint.applying(self.transform)
        
        var position = self.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        self.layer.position = position
//        self.layer.anchorPoint = anchorPoint
    }
    
    /////////////////////////////////////////////
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
        if borderWidth > 0 {
            addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
        }
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        self.layer.addSublayer(borderLayer)
    }
    
    func addSubViewWithAnimation(subView: UIView) {
        subView.alpha = 0
        self.addSubview(subView)
        subView.frame = self.bounds
        UIView.animate(withDuration: 0.4) {
            subView.alpha = 1
        }
    }
    
    func removeSubViewWithAnimation(subView: UIView) {
        UIView.animate(withDuration: 0.4, animations: {
            subView.alpha = 0
        }) { (success) in
            if success {
                subView.removeFromSuperview()
            }
        }
    }
    
    func startShimmering()
    {
        let light = UIColor.red.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.4).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha, alpha, light, alpha]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [1.0, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        self.layer.mask?.add(animation, forKey: "shimmer")
        

    }
    func stopShimmering()
    {
        self.layer.mask = nil;

    }
    func rotate90(_ toValue:CGFloat){
        self.transform = CGAffineTransform(rotationAngle: toValue)
    }
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.3) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
    
   
}
@IBDesignable
class DashedLineView : UIView {
    @IBInspectable var perDashLength: CGFloat = 2.0
    @IBInspectable var spaceBetweenDash: CGFloat = 2.0
    @IBInspectable var dashColor: UIColor = UIColor.lightGray


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width

        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }

        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

    private var width : CGFloat {
        return self.bounds.width
    }

    private var height : CGFloat {
        return self.bounds.height
    }
}
extension UIView
{
    func hideViewAnimated( subviews:[UIView], hide:Bool, minimizeBtn:UIButton?, minimizeImage:UIImage?, expandImage:UIImage?, animated:Bool = true)
    {
        subviews.forEach { (view) in
            view.isHidden = hide
            view.alpha = 0
        }
        UIView.animate(withDuration:animated ? 0.25 : 0) {
            self.layoutIfNeeded()
            
            subviews.forEach { (view) in
                view.alpha =   1
            }
            minimizeBtn?.setImage(hide ? minimizeImage : expandImage, for: .normal)
        }
    }
    
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
    
    
}

extension UIStackView
{
  
}
extension UIScrollView
{
    func flipRTL()
       {
        if !PersistanceUtil.isLanguageArabic()
        {
            return
        }
           self.transform = CGAffineTransform(scaleX:-1,y: 1)
           self.subviews.first?.transform = CGAffineTransform(scaleX:-1,y: 1)
        

       }
}
extension UICollectionView
{
    func flipRightToLeft()
       {
        if !PersistanceUtil.isLanguageArabic()
        {
            return
        }
           self.transform = CGAffineTransform(scaleX:-1,y: 1)
        

       }
}

extension UICollectionViewCell
{
    func flipRightToLeft()
       {
        if !PersistanceUtil.isLanguageArabic()
        {
            return
        }
           self.transform = CGAffineTransform(scaleX:-1,y: 1)
        

       }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = false
        rotation.repeatCount = Float.nan
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    
}

extension UIView{
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

       layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

//For View Shadow
extension UIView{
    func SetViewShadow(){
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: -3 , height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 7
    }
    func setGradientBackgrounds(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
