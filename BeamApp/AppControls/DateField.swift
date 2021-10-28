//
//  DateField.swift

//

import Foundation
import UIKit

class DateField: AppField {
    var picker: UIDatePicker = UIDatePicker()
    var selectedDate: Date {
        get {
            return self.picker.date
        }
        set {
            self.picker.date = newValue
            self.setDateText()
        }
    }

    @IBInspectable var dateFormatKey: String = "dd/MM/yyyy"
    @IBInspectable var timeFormatKey: String = "HH:mm:ss"

    @IBInspectable var dateModeKey: String = "date" {

        didSet {
            switch dateModeKey {
            case "dateAndTime":
                self.datePickerDateMode = .dateAndTime
            case "date":
                self.datePickerDateMode = .date
            case "time":
                 self.datePickerDateMode = .time
            default:
                self.datePickerDateMode = .date
            }
        }
    }
    var datePickerDateMode: UIDatePicker.Mode? = .date
    var minimumDate: Date? {
        didSet {
            self.picker.minimumDate = minimumDate
        }
    }
    var maximumDate: Date? {
        didSet {
            self.picker.maximumDate = maximumDate
        }
    }
    
    override func commonInit() {
        super.commonInit()
        if #available(iOS 13.4, *) {
            self.picker.preferredDatePickerStyle = .wheels
        }
        self.inputView = self.picker
        self.tintColor = UIColor.clear
        self.inputAccessoryView = self.toolBar

        self.picker.datePickerMode = datePickerDateMode!
        if let maxDate = self.maximumDate {
            self.picker.maximumDate = maxDate
        }
        if let minDate = self.minimumDate {
            self.picker.maximumDate = minDate
        }
        let calendar = Calendar(identifier: .gregorian)
        let identifier = Organizer.shared.appLanguage == .english ? "English" : "Arabic"
        self.picker.locale = Locale(identifier: identifier)
        self.picker.calendar = calendar
        var dayComponent = DateComponents()
        dayComponent.year = -1
        let lastYearDate = calendar.date(byAdding: dayComponent, to: Date())
        self.picker.date = lastYearDate ?? Date()
    }
    lazy var toolBar: UIToolbar = {
        var toolBar = UIToolbar()
        toolBar.tintColor = UIColor.AppColor.primary
        toolBar.backgroundColor = UIColor.AppColor.primary
        toolBar.barTintColor = UIColor.AppColor.primary
        var doneButton = AppButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        doneButton.setTitleColor(UIColor.AppColor.white, for: .normal)
        doneButton.fontStyle = "bold"
        doneButton.fontSize = "20"
        doneButton.setTitle("OK".localizedString, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonPressed(sender:)), for: .touchUpInside)
        let doneBarButton = UIBarButtonItem(customView: doneButton)

        var cancelButton = AppButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        cancelButton.setTitle("lstr_cancel".localizedString, for: .normal)
        cancelButton.setTitleColor(UIColor.AppColor.white, for: .normal)
        cancelButton.fontStyle = "bold"
        cancelButton.fontSize = "20"

        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(sender:)), for: .touchUpInside)
        let cancelBarButton = UIBarButtonItem(customView: cancelButton)

        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBarButton, spaceButton, doneBarButton], animated: false)
        toolBar.sizeToFit()

        return toolBar

    }()

    @objc func doneButtonPressed(sender: UIButton) {
        self.setDateText()
        
    }

    @objc func cancelButtonPressed(sender: UIButton) {
        self.resignFirstResponder()

    }
    fileprivate func setDateText() {
        let formatter = DateFormatter()
        if dateModeKey == "time" {
            formatter.dateFormat = self.timeFormatKey
        } else {
            formatter.dateFormat = self.dateFormatKey
        }
        let identifier = Organizer.shared.appLanguage == .english ? "English" : "Arabic"
        formatter.locale = Locale(identifier: identifier)
        self.text = formatter.string(from: self.picker.date)
        self.resignFirstResponder()
        self.text = formatter.string(from: self.picker.date)
        if let externalDelegate = self.externalDelegate {
            return externalDelegate.apptextFieldDidChange!(self)
        }
        
    }

}
