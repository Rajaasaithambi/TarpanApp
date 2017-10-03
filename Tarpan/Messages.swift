//
//  Messages.swift
//  Tarpan
//
//  Created by Praveen P on 8/12/16.
//  Copyright © 2016 minuscale. All rights reserved.
//

import Foundation

struct InvalidAlert {
    
    func create(forRelationType relationType: String) -> (title: String, message: String) {
        return (title: "Invalid \(relationType)", message: "Please a valid \(relationType)")
    }
    
}
struct Constants {
    
    struct Messages {
        
        static let EmailAlreadyRegistered = (title: "Email ID already exists", message: "There is an account associated with this email ID");
        static let LoginUserIDValidation = (title: "Incorrect username and password", message: "Please Enter The Correct username and password")
        static let TextFieldEmpty = (title: "All Fields Required", message: "Please Enter The all fields")
        static let InCorrectPassword = (title: "Incorrect Password", message: "Does't match password")
        static let Password = (title: "Password", message: "Please enter 4 digit number")
        static let InvalidName = (title: "Invalid Name", message: "Please enter a valid name");
        static let InvalidMobile = (title: "Invalid Mobile Number", message: "Please enter a valid mobile number");
        static let InvalidEmail = (title: "Invalid Email Id", message: "Please enter a valid Email ID");
        static let InvalidCredentials = (title: "Authentication Failure", message: "Invalid username or password");
        static let InvalidCountryValue = (title: "Invalid Country", message: "Please select the country");
        static let InvalidSectionValue = (title: "Invalid Section", message: "Please select the section");
        static let InvalidVedamValue = (title: "Invalid Vedam", message: "Please select the Vedam");
        static let InvalidSuthramValue = (title: "Invalid Suthram", message: "Please select the Suthram");
        static let InvalidGothram = (title: "Invalid Gothram", message: "Please enter a valid Gothram");
        static let InvalidValue = InvalidAlert();
        static let mothersGotram = (title: "Alert", message: "Please Enter mothersGotram");
        static let mothersName = (title: "Alert", message: "Please Enter mothersName");
        static let mothersFatherName = (title: "Alert", message: "Please Enter MothersFatherName");
        static let mothersMotherName = (title: "Alert", message: "Please Enter MothersMotherName");
        static let mothersgrandFatherName = (title: "Alert", message: "Please Enter MothersGrandFatherName");
        static let mothersgrandMotherName = (title: "Alert", message: "Please Enter MothersGrandMotherName");
        static let mothersgreategrandFatherName = (title: "Alert", message: "Please Enter MothersGreatGrandFatherName");
        static let mothersgreategrandMotherName = (title: "Alert", message: "Please Enter mothersGreatGrandMotherName");
        static let fathersGotram = (title: "Alert", message: "Please Enter FathersGotram");
        
        static let fathersFatherName = (title: "Alert", message: "Please Enter FathersName");
        static let fathersMotherName = (title: "Alert", message: "Please Enter FathersMotherName");
        static let fathersgrandFatherName = (title: "Alert", message: "Please Enter FathersGrandFathersName");
        static let fathersgrandMotherName = (title: "Alert", message: "Please Enter FathersGrandMotherName");
        static let fathersgreategrandFatherName = (title: "Alert", message: "Please Enter FathersGreatGrandFatherName");
        static let fathersgreategrandMotherName = (title: "Alert", message: "Please Enter FathersGreatGrandMotherName");
        static let gotramValidate = (title: "Invalid Gotram", message: "Please Enter a valid Gotram");
        static let nameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersName");
        static let fatherNameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersFatherName");
        static let motherNameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersMotherName");
        static let grandFatherNameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersGrandFatherName");
        static let grandMotherNameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersGrandmotherName");
        static let greateGrandFatherNameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersGreatGrandFatherName");
        static let greateGrandMotherNameValidate = (title: "Invalid Name", message: "Please Enter a valid mothersGreatGrandMotherName");
        static let gotramValidate1 = (title: "Invalid Gotram", message: "Please Enter a valid Gotram");
        static let nameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersName");
        static let fatherNameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersFatherName");
        static let motherNameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersMotherName");
        static let grandFatherNameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersGrandFatherName");
        static let grandMotherNameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersGrandmotherName");
        static let greateGrandFatherNameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersGreatGrandFatherName");
        static let greateGrandMotherNameValidate1 = (title: "Invalid Name", message: "Please Enter a valid fathersGreatGrandMotherName");
        static let AudioDownloadFailed = (title: "Audio Download Failed", message: "Could not download the audio. Please retry");
        static let MobileFieldMissing = (title: "MobileFieldMissing", message: "Please enter the mobile number")
        static let passwordFieldMissing = (title: "passwordFieldMissing", message: "Please enter the password")
        static let nameFieldMissing = (title: "nameFieldMissing", message: "Please enter the name")
        static let emailFieldMissing = (title: "emailFieldMissing", message: "Please enter the emailId")
        static let countryFieldMissing = (title: "countryFieldMissing", message: "Please select the country")
        static let OTPFieldMissing = (title: "OTPFieldMissing", message: "Please enter the OTP")

    }
}
