//
//  ValidationUtils.swift

//

import Foundation
struct ValidationConstants
{
    static let generalMaxLength = 14
    static let passwordMaxLength = 16
    static let passwordMinLength = 8
    static let mobileNumberMinLength = 6
    static let mobileNumberMaxLength = 9

}
struct ValidationMessageConstants
{
    // naming condition (drop valid for shortness) and then followByFail: Eg condition is validFirstName -> fisrtNameFail
    static let firstNameEmpty = "Please enter your full name".localizedString
    static let lastNameEmpty = "Please enter your last name".localizedString
    static let emailEmpty = "Please enter your email".localizedString
    static let emailFormatFail = "Please enter a valid email address".localizedString
    static let mobileCodeEmpty = "Please enter your mobile code".localizedString
    static let mobileCodeFormatFail = "Please enter a valid mobile code".localizedString
    static let mobileNumberEmpty = "Please enter your mobile number".localizedString
    static let mobileNumberFormatFail = "Please enter a valid mobile number".localizedString
    static let passwordEmpty = "Please enter a password".localizedString
    static let confirmPasswordEmpty = "Please enter a confirm Password".localizedString
    static let passwordMinLengthFail = "Password should contain at least %d character".localizedString
    static let passwordMaxLengthFail = "Password should be less than %d character".localizedString
    static let passwordFormatFail = "Minimum 8 characters, at least one letter, one number and one special character(@#$%^&amp;+=*!) required".localizedString
    static let residenceEmpty = "Please enter your residence".localizedString
    static let confirmPasswordCompare = "Password does not match.".localizedString
    static let agreeButton = "Please select to agree to mom store's terms & conditions and privacy policy".localizedString
    
    static let addressLine1Empty = "Please enter your address line 1".localizedString
    static let addressLine2Empty = "Please enter your address line 2".localizedString
    static let countryEmpty = "Please select your country".localizedString
    static let cityEmpty = "Please select your city".localizedString
    static let areaEmpty = "Please select your area".localizedString
    static let currentpasswordEmpty = "Please enter current password".localizedString
    static let newpasswordEmpty = "Please enter new password".localizedString
}
struct ValidationResult
{
    var passed = true
    var message = ""
    
    init(passed:Bool , message:String)
    {
        self.passed = passed
        self.message = message
    }
    
}
