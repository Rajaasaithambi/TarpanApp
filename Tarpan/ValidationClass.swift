//
//  ValidationClass.swift
//  Tarpan
//
//  Created by raja A on 6/1/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import Foundation

/*public extension String {
func startsWith(_ string:String) -> Bool
{
    if (string == self)
    {
        return true;
    }
    if (string.characters.count > self.characters.count)
    {
        return false;
    }
    let startIndex = self.characters.index(self.startIndex, offsetBy: 0)
    let endIndex   = string.characters.index(startIndex, offsetBy: string.characters.count)
    let range      = (startIndex ..< endIndex)
    
    let subString = self.substring(with: range);
    return subString.lowercased() == string.lowercased();
}*/

func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func isValidatePhoneNo(phoneNumber: String) -> Bool {
    let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
    let inputString = phoneNumber.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    return  phoneNumber == filtered
}
func isValidName(name: String) -> Bool {
    //let emailRegEx = "([a-zA-Z]{3,50}\\s?[a-zA-Z]{0,50})*"
    let emailRegEx = "([a-zA-Z]{3,50}\\s?)+"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: name)
    return result
}

/*func isMobileNumber() -> Bool
{
    //        var urlString = "";
    // Original
    //var regexString1 = "^(\\+0|7|8|9)\\d{9}$";
    // Testing
    let regexString1 = "^(\\+0|3|7|8|9)\\d{9}$";
    //        let stringlength = self.characters.count
    //        var ierror: NSError?
    var regex:NSRegularExpression = try! NSRegularExpression(pattern: regexString1, options: NSRegularExpression.Options.caseInsensitive)
    //        var modString = regex.stringByReplacingMatchesInString(self.lowercaseString, options: [], range: NSMakeRange(0, stringlength), withTemplate: "-")
    
    regex = try! NSRegularExpression(pattern: regexString1, options: NSRegularExpression.Options.caseInsensitive)
    let matchingCount = regex.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.characters.count))
    return (matchingCount > 0);
    }
}*/
