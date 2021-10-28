//
//  PersistanceUtil.swift

//

import UIKit
import SwiftyJSON

class PersistanceUtil: NSObject {
    enum PersistanceKeys:String
    {
        case userResponseJSON  = "keyUserResponseJSON"
        case basicConfigJSON  = "keyBasicConfigJSON"
        case acccessToken  = "keyAcccessToken"
        case acccessTokenCustomer  = "keyAcccessTokenCustomer"
        case experienceValue  = "experienceValue"
        case showCommentry = "showCommentry"
    }
    
    class func getSavedObject(forKey: String) -> Any? {
        let savedObject = UserDefaults.standard.object(forKey: forKey)
        return savedObject
    }
    
    class func saveObject(_ object: Any?, forKey key:String!) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }
    class func setLanguage()
    {
        if isLanguageArabic()
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
        }
    }
    class func isLanguageArabic() -> Bool
    {
        return Organizer.shared.appLanguage == .arabic
    }
    
    class func saveUserJSONResponse(_ response:JSON?) {
        saveObject(response?.rawString() ?? "", forKey: PersistanceKeys.userResponseJSON.rawValue)
    }
    
    class func savedUserJSONResponse() ->  JSON?{
        
        let jsonString = UserDefaults.standard.string(forKey: PersistanceKeys.userResponseJSON.rawValue) ?? ""
        guard jsonString.isValid else
        {
            return nil
        }
        guard let data = jsonString.data(using: .utf8, allowLossyConversion: false)  else {
            return nil
        }
        do
        {
            let json = try JSON(data: data)
            return json
        }
        catch
        {
            return nil
        }
    }
    class func saveAccessToken(_ token:String) {
        saveObject(token, forKey: PersistanceKeys.acccessToken.rawValue)
    }
    class func saveAccessTokenCustomer(_ token:String) {
        saveObject(token, forKey: PersistanceKeys.acccessTokenCustomer.rawValue)
    }
    class func saveExperienceValue(_ expValue: Int?) {
        guard expValue != nil else { return }
        saveObject(expValue, forKey: PersistanceKeys.experienceValue.rawValue)
    }
    
    
    class func savedAccessToken() ->  String?{
        if let accessToken = UserDefaults.standard.string(forKey: PersistanceKeys.acccessToken.rawValue){
            if accessToken.isValid{
                return accessToken
            }
            return nil
        }
        return nil
      //  return UserDefaults.standard.string(forKey: PersistanceKeys.acccessToken.rawValue) ?? ""
    }
    class func savedAccessTokenCustomer() ->  String?{
        if let accessToken = UserDefaults.standard.string(forKey: PersistanceKeys.acccessTokenCustomer.rawValue){
            if accessToken.isValid{
                return accessToken
            }
            return nil
        }
        return nil
       // return UserDefaults.standard.string(forKey: PersistanceKeys.acccessTokenCustomer.rawValue) ?? ""
    }
    class func saveBasicConfigJSON(_ response:JSON?) {
        saveObject(response?.rawString() ?? "", forKey: PersistanceKeys.basicConfigJSON.rawValue)
    }
    
    class func savedBasicConfigJSON() ->  JSON?{
        
        let jsonString = UserDefaults.standard.string(forKey: PersistanceKeys.basicConfigJSON.rawValue) ?? ""
        guard jsonString.isValid else
        {
            return nil
        }
        guard let data = jsonString.data(using: .utf8, allowLossyConversion: false)  else {
            return nil
        }
        do
        {
            let json = try JSON(data: data)
            return json
        }
        catch
        {
            return nil
        }
    }
    
    class func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-dd-MM"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate ?? Date(), to: now, options: [])
        guard let age = calcAge.year else {return 0}
        return age-1
    }
    
    class func calculateAge(dob : String, format:String = "yyyy-dd-MM") -> (year :Int, month : Int, day : Int){
            let df = DateFormatter()
            df.dateFormat = format
            let date = df.date(from: dob)
            guard let val = date else{
                return (0, 0, 0)
            }
            var years = 0
            var months = 0
            var days = 0
            
            let cal = Calendar.current
            years = cal.component(.year, from: Date()) -  cal.component(.year, from: val)
            
            let currMonth = cal.component(.month, from: Date())
            let birthMonth = cal.component(.month, from: val)
            
            //get difference between current month and birthMonth
            months = currMonth - birthMonth
            //if month difference is in negative then reduce years by one and calculate the number of months.
            if months < 0
            {
                years = years - 1
                months = 12 - birthMonth + currMonth
                if cal.component(.day, from: Date()) < cal.component(.day, from: val){
                    months = months - 1
                }
            } else if months == 0 && cal.component(.day, from: Date()) < cal.component(.day, from: val)
            {
                years = years - 1
                months = 11
            }
            
            //Calculate the days
            if cal.component(.day, from: Date()) > cal.component(.day, from: val){
                days = cal.component(.day, from: Date()) - cal.component(.day, from: val)
            }
            else if cal.component(.day, from: Date()) < cal.component(.day, from: val)
            {
                let today = cal.component(.day, from: Date())
                let date = cal.date(byAdding: .month, value: -1, to: Date())
                
                days = date!.daysInMonth - cal.component(.day, from: val) + today
            } else
            {
                days = 0
                if months == 12
                {
                    years = years + 1
                    months = 0
                }
            }
            
            return (years, months, days)
        }
    
}

func saveUploadedFilesSet(fileName:[String : Any]) {
    let file: FileHandle? = FileHandle(forWritingAtPath: "BasicConfig.json")

    if file != nil {
        // Set the data we want to write
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: fileName, options: .init(rawValue: 0))
                // Check if everything went well
            file?.write(jsonData)

                // Do
        }
        catch {

        }
        // Write it to the file

        // Close the file
        file?.closeFile()
    }
    else {
        print("Ooops! Something went wrong!")
    }
}
