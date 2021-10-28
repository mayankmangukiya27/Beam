//
//  AppField.swift


import UIKit
//import SnapKit
public enum FieldStyle:String {
    case custom = "custom"
    case primary = "primary"
    
    static func build(rawValue:String) -> FieldStyle {
        return FieldStyle(rawValue: rawValue) ?? .custom
    }
}

@objc protocol AppFieldDelegate {
    @objc optional func apptextFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    
    @objc optional func apptextFieldDidBeginEditing(_ textField: UITextField)
    
    @objc optional  func apptextFieldShouldEndEditing(_ textField: UITextField) -> Bool
    
    @objc optional  func apptextFieldDidEndEditing(_ textField: UITextField)
    
    @objc optional  func apptextFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason)
    
    @objc optional  func apptextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    @objc optional  func apptextFieldShouldClear(_ textField: UITextField) -> Bool
    
    @objc optional  func apptextFieldShouldReturn(_ textField: UITextField) -> Bool
    
    @objc optional func apptextFieldDidChange(_ textField: UITextField)
}

@IBDesignable class  AppField: UITextField {
    
    var underlineLayer:CALayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
        self.updateLocalizedText()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        self.clipsToBounds = true
        self.borderStyle = .none
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.showAsOnFocus(focused: false)
       
        if let clearButton:UIButton = self.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage.init(named: "error"), for: .normal)
        }
        if PersistanceUtil.isLanguageArabic()
        {
            self.textAlignment = .right

        }
        self.styleValue = FieldStyle.primary.rawValue
    }
    
    private var maxLengths = [UITextField: Int]()

    var leftButton:UIButton?
    var rightButton:UIButton?
    var centerButton:UIButton?
    
    var leftBtnWidth:CGFloat = 20
    var rightBtnWidth:CGFloat = 20
    var kPasswordEyeTag = 35
    
    var validationLabel:AppLabel?
    var underLineView = UIView()
    var externalDelegate:AppFieldDelegate?
//    @IBInspectable
     var styleValue:String = FieldStyle.primary.rawValue {
        didSet {
          applyStyle()
        }
    }
    
    func applyStyle() {
        let style = FieldStyle.init(rawValue: styleValue)
        guard style != FieldStyle.custom else {
            return
        }
        self.fontSize =  ControlConfig.FontSizeSlug.textField.rawValue
        self.fontStyle =  ControlConfig.FontStyleSlug.light.rawValue
        self.changeColorWhenFocused = true
        self.borderStyle = .none
        self.clipsToBounds = true
        self.tintColor  = UIColor.AppColor.primary
        if style == FieldStyle.primary {
            self.txtColorCode = ControlConfig.ColorSlug.custom.rawValue
            self.underLineColorCode = ControlConfig.ColorSlug.custom.rawValue
            self.underLineColorFocused = ControlConfig.ColorSlug.custom.rawValue
            self.bgColorCode = ControlConfig.ColorSlug.custom.rawValue
            self.sidePadding = 16
            self.shadowEnabled = false

            self.layer.cornerRadius = 8
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
        self.setNeedsLayout()
    }
    @IBInspectable
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    @IBInspectable
    var sidePadding:CGFloat =  0 {
        didSet {
            padding.left = sidePadding
            padding.right = sidePadding
        }
    }
    var leftInset:CGFloat = 8

    @IBInspectable
    var shouldUpperCase:Bool = false {
        didSet {
            if shouldUpperCase {
                self.updateUpperCaseText()
            }
        }
    }
    @IBInspectable var textString:String = "" {
        didSet {
            self.updateLocalizedText()
        }
    }
//    @IBInspectable
    var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    
    @IBInspectable var placeholderKey:String = "" {
        didSet {
            self.updateLocalizedPlaceholderText()
        }
    }
    
    @IBInspectable var placeholderColorCode:String = ControlConfig.ColorSlug.placeholder.rawValue {
        didSet {
            let color = ControlConfig.colorForCode(ControlConfig.ColorSlug(rawValue: placeholderColorCode) ?? ControlConfig.ColorSlug.placeholder)
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? self.placeholderKey,
                                             attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
    
//    @IBInspectable
    var validationKey:String = "" {
        didSet {
            self.setValidationText()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            self.addLeftButton()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            self.addRightButton()
        }
    }

    @IBInspectable var enableCenterButton: Bool = false {
        didSet {
            if enableCenterButton {
                self.addCenterButton()
            }
        }
    }
    
//    @IBInspectable
    var txtColorFocusedCode:String = ControlConfig.ColorSlug.primary.rawValue
//    @IBInspectable
    var underLineColorCode:String = ControlConfig.ColorSlug.primary.rawValue
//    @IBInspectable
    var underLineColorFocused:String = ControlConfig.ColorSlug.primary.rawValue
//    @IBInspectable
    var changeColorWhenFocused:Bool = false
//    @IBInspectable
    
    
    
    @IBInspectable
    var txtColorCode:String = ControlConfig.ColorSlug.primary.rawValue {
        didSet {
            self.setTextColorFromCode()
        }
    }
    
    
    @IBInspectable
    var fontStyle:String = ControlConfig.FontStyleSlug.regular.rawValue {
        didSet {
            self.setFontStyleFromCode()
        }
    }
    
    @IBInspectable
    var fontSize:String = ControlConfig.FontSizeSlug.textField.rawValue {
        didSet {
            self.setFontSizeFromCode()
        }
    }

    @IBInspectable
    var bgColorCode:String = ControlConfig.ColorSlug.custom.rawValue {
        didSet {
            self.setBgColorFromCode()
        }
    }
    
    @IBInspectable
    var showClearBtn:Bool = false {
        didSet {
            self.clearButtonMode = .whileEditing
        }
    }
    
    @objc func tappedClear(_ sender:UIButton) {
        self.text = ""
    }
    
    func updateUpperCaseText() {
        self.text = self.shouldUpperCase ? self.textString.localizedString.uppercased() : self.textString.localizedString
        self.placeholder = self.shouldUpperCase ? self.placeholderKey.localizedString.uppercased() : self.placeholderKey.localizedString
    }
    
    func updateLocalizedText() {
        self.text = self.textString.localizedString
    }
    
    @objc func limitLength() {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
    
    func updateLocalizedPlaceholderText() {
        self.placeholder = self.placeholderKey.localizedString
        self.attributedPlaceholder = NSAttributedString(string: self.placeholderKey.localizedString,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.AppColor.placeholder])
//        self.placeholder = ""

//        self.externalLabel?.text = self.placeholderKey.localizedString
    }
    
    func setValidationText() {
        self.validationLabel?.text = self.validationKey.localizedString
    }
    
    func setTextColorFromCode() {
        let code = ControlConfig.ColorSlug.build(rawValue: txtColorCode)
        self.textColor = ControlConfig.colorForCode(code , customColor: self.textColor)
    }
    
    func setFontStyleFromCode() {
        let code = ControlConfig.FontStyleSlug.build(rawValue: fontStyle)
        self.font = ControlConfig.fontForStyleCode(code, customStyle:self.font?.fontName, fontSize: self.font?.pointSize)
    }
    
    func setFontSizeFromCode() {
        let floatValue = Float(fontSize) ?? Float(15)
        let newFontSize: CGFloat = CGFloat.init(floatValue)
        let code = ControlConfig.FontSizeSlug.build(rawValue:fontSize)
        self.font = ControlConfig.fontForSizeCode(code, customSize: newFontSize,  fontName: self.font?.fontName)
    }
    
    func setBgColorFromCode() {
        let code = ControlConfig.ColorSlug.build(rawValue:bgColorCode)
        self.backgroundColor = ControlConfig.colorForCode(code , customColor: self.backgroundColor)
    }
    
    
    func showAsOnFocus(focused:Bool) {
        if(focused) {
            let focusedColor =  ControlConfig.colorForCode(ControlConfig.ColorSlug.build(rawValue: underLineColorFocused), customColor: UIColor.lightGray)
            underlineLayer = CALayer()
            if  let animateLayer = underlineLayer {
                animateLayer.bounds =  self.underLineView.frame
                animateLayer.anchorPoint = CGPoint(x: 0, y: 0)
                animateLayer.backgroundColor = focusedColor.cgColor
                underLineView.layer.addSublayer(animateLayer)
                let anim = CABasicAnimation(keyPath: "bounds")
                anim.duration = 0.3
                anim.fromValue = NSValue.init(cgRect: CGRect.init(x: 0, y: 0, width: 0, height: 2))
                anim.toValue = NSValue.init(cgRect: CGRect.init(x: 0, y: 0, width:  self.underLineView.frame.size.width, height: 2))
                animateLayer.add(anim, forKey: "anim")
            }
        }
        else {
            underlineLayer?.removeFromSuperlayer()
            underLineView.backgroundColor = ControlConfig.colorForCode(ControlConfig.ColorSlug.build(rawValue: underLineColorCode), customColor: UIColor.lightGray)
        }
    }
    
    func showPasswordEyes(){
        let btn = UIButton()
        btn.tintColor = UIColor.AppColor.primary
        btn.setImage(#imageLiteral(resourceName: "showPass"), for: .selected)
        btn.setImage(#imageLiteral(resourceName: "hidePass"), for: .normal)
        btn.tag = kPasswordEyeTag
        btn.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        self.addSubview(btn)
        btn.snp.makeConstraints { (make) -> Void in
            make.rightMargin.equalTo(-10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    @objc private func showPassword(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            self.isSecureTextEntry = false
        }
        else{
            self.isSecureTextEntry = true
        }
        self.text = self.text
    }
    
    func addValidationMessage() {

        self.validationLabel = AppLabel.init(frame: .zero)
        self.validationLabel!.font = UIFont.init(name: UIFont.AppFont.regular, size: 14)
        self.validationLabel?.txtColorCode = ControlConfig.ColorSlug.primary.rawValue
        self.validationLabel?.fontStyle = "medium"
        self.validationLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.validationLabel!.backgroundColor = .clear

        self.superview?.addSubview(self.validationLabel!)

        self.validationLabel!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(24)
            make.height.equalTo(21)
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(self)
        }
    }

    func addLeftButton() {
        if let image = self.leftImage {
            if self.leftButton == nil {
                self.leftButton = UIButton.init(type: .custom)
                self.leftButton?.frame = CGRect.init(x: 0, y: 0, width: leftBtnWidth, height: leftBtnWidth)
                self.leftView = self.leftButton
                var padding = self.padding
                padding.left = leftBtnWidth + leftInset
//                self.padding = padding
                self.leftViewMode = .always
                self.leftButton?.contentHorizontalAlignment = .center
                self.rightImage = UIImage()
                self.leftButton?.imageView?.contentMode = .scaleAspectFit
            }
            self.leftButton?.setImage(image, for: .normal)
        } else {
            self.leftButton?.setImage(self.leftImage, for: .normal)
        }

    }
    func addRightButton() {

        if let image = self.rightImage {
            if self.rightButton == nil {
                self.rightButton = UIButton.init(type: .custom)
                self.rightButton?.contentHorizontalAlignment = .center
                self.rightButton?.setImage(image, for: .normal)
                self.rightButton?.frame = CGRect.init(x: 0, y: 0, width: rightBtnWidth, height: rightBtnWidth)
                var padding = self.padding
                padding.right = rightBtnWidth //+ leftInset
                self.padding  = padding
                self.rightButton?.imageView?.contentMode = .scaleAspectFit
                self.rightView = self.rightButton
                self.rightViewMode = .always
                self.leftImage = UIImage()

            }
            self.rightButton?.setImage(image, for: .normal)
        } else {
            self.rightButton = nil
            var padding = self.padding
            padding.right = sidePadding
            self.padding  = padding
            self.rightView = nil

        }
    }
    
    func addCenterButton() {

        self.centerButton = UIButton.init(type: .custom)
        self.centerButton?.backgroundColor = UIColor.clear
        self.addSubview(self.centerButton!)
        self.centerButton?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets.zero)
        })
        self.bringSubviewToFront(self.centerButton!)
        if let leftBtn = self.leftButton {
            self.bringSubviewToFront(leftBtn)

        }
        if let rightBtn = self.rightButton {
            self.bringSubviewToFront(rightBtn)

        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
        self.updateLocalizedText()
        self.updateLocalizedPlaceholderText()
        self.setTextColorFromCode()
        self.setFontStyleFromCode()
        self.setFontSizeFromCode()
        self.setBgColorFromCode()
//        self.addUnderLineView()
//        self.addExternalPlaceHolder()
        self.addValidationMessage()
        self.addLeftButton()
        self.addRightButton()
//        self.setBorderColorFromCode()
        self.updateUpperCaseText()
    }
    
    func updatePadding()
    {
        var leading:CGFloat = 0
        var trailing:CGFloat = padding.right
        if(padding.right == 0 && self.clearButtonMode != .never)
        {
            trailing = 24
        }
        leading = sidePadding + (leftButton?.frame.size.width ?? 0)
        if PersistanceUtil.isLanguageArabic()
        {
            padding.left = trailing
            padding.right = leading
        }
        else
        {
            padding.left = leading
            padding.right = trailing
        }

       
    }
   override func textRect(forBounds bounds: CGRect) -> CGRect {
       if(padding.right == 0 && self.clearButtonMode != .never) {
           padding.right = 24
       }
       return bounds.inset(by: padding)
//    updatePadding()
//    return bounds.inset(by: padding)
    }

    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        updatePadding()
        if(padding.right == 0 && self.clearButtonMode != .never) {
            padding.right = 24
        }
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        updatePadding()
        if(padding.right == 0 && self.clearButtonMode != .never) {
            padding.right = 24
        }
        return bounds.inset(by: padding)
    }
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var x = sidePadding
        if PersistanceUtil.isLanguageArabic()
        {
            x = self.bounds.width - sidePadding - (leftButton?.frame.size.width ?? 0)
        }
        return CGRect(x:  x, y: 0, width: leftButton?.frame.size.width ?? 0 , height: bounds.height)
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var x = bounds.width - (rightButton?.frame.size.width ?? 0) - sidePadding
        if PersistanceUtil.isLanguageArabic()
        {
            x = sidePadding
        }
        return CGRect(x:  x, y: 0, width: (rightButton?.frame.size.width ?? 0) , height: bounds.height)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        externalDelegate?.apptextFieldDidChange?(textField)
    }
}

extension AppField:UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        externalDelegate?.apptextFieldDidEndEditing?(textField)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return externalDelegate?.apptextFieldShouldBeginEditing?(textField) ?? true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let btn = self.viewWithTag(kPasswordEyeTag) as? UIButton{
            self.bringSubviewToFront(btn)
        }
        if let externalDelegate = self.externalDelegate {
            externalDelegate.apptextFieldDidBeginEditing?(textField)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let btn = self.viewWithTag(kPasswordEyeTag) as? UIButton{
            self.bringSubviewToFront(btn)
        }
        
        return externalDelegate?.apptextField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(self.changeColorWhenFocused) {
            self.showAsOnFocus(focused: false)
        }
        if let externalDelegate = self.externalDelegate {
            return externalDelegate.apptextFieldShouldEndEditing?(textField) ?? true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let externalDelegate = self.externalDelegate {
            return externalDelegate.apptextFieldShouldReturn?(textField) ?? true
        }
        return false
    }
}

extension AppField {
    func nonEmptyText() -> String? {
        if let currentText = self.text, !currentText.isEmpty {
            return currentText
        }
        return nil
    }
}
