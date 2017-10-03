//
//  InitialViewController.swift
//  Tarpan
//
//  Created by raja A on 9/14/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import CoreData

class SignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var mobileNoTxt: HoshiTextField!
    @IBOutlet var countryTxt: UITextField!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var firstTxt: UITextField!
    @IBOutlet var secondTxt: UITextField!
    @IBOutlet var thirdTxt: UITextField!
    @IBOutlet var fourthTxt: UITextField!
    @IBOutlet var otpViews: UIView!

    let openMenu = DropMenu()
    var deviceID = String()
    var tarpanArr = [NSManagedObject]()
    let url = "https://ahqyu615vj.execute-api.us-east-1.amazonaws.com/tarpanregistration"

    override func viewDidLoad() {
        super.viewDidLoad()
        deviceID = UIDevice.current.identifierForVendor!.uuidString
        title = "InitialView"
        mobileNoTxt.delegate = self
        countryTxt.delegate = self
        firstTxt.delegate = self
        secondTxt.delegate = self
        thirdTxt.delegate = self
        fourthTxt.delegate = self
        scrollview.isScrollEnabled = false
        otpViews.isHidden = true
        mobileNoTxt.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        firstTxt.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        secondTxt.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        thirdTxt.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fourthTxt.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        tapGesture()

    }

    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func validateBtn(_ sender: UIButton) {
        
        if (countryTxt.text?.isEmpty)! {
            alert(Constants.Messages.countryFieldMissing.title, message: Constants.Messages.countryFieldMissing.message)
        }else if (mobileNoTxt.text?.isEmpty)! {
             alert(Constants.Messages.MobileFieldMissing.title, message: Constants.Messages.MobileFieldMissing.message)
        }else if (firstTxt.text?.isEmpty)! || (secondTxt.text?.isEmpty)! || (thirdTxt.text?.isEmpty)! || (fourthTxt.text?.isEmpty)! {
            alert(Constants.Messages.OTPFieldMissing.title, message: Constants.Messages.OTPFieldMissing.message)
        }else {
            let mobile = mobileNoTxt.text
            let isValidateMobileNo = isValidatePhoneNo(phoneNumber: mobile!)
            if isValidateMobileNo {
                if mobile?.characters.count == 12 {
                    if Reachability.isConnectedToNetwork() == true {
                        self.view.showLoadingView()
                        DispatchQueue.main.async {
                            self.validateDate(VmobileNo: mobile!, Vudid: self.deviceID, first: self.firstTxt.text!, second: self.secondTxt.text!, third: self.thirdTxt.text!, fouth: self.fourthTxt.text!)
                        }
                    }else {
                        let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Okey", style: .default)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }

                }else {
                    alert(Constants.Messages.InvalidMobile.title, message: Constants.Messages.InvalidMobile.message)
                }
            }else {
                alert(Constants.Messages.InvalidMobile.title, message: Constants.Messages.InvalidMobile.message)
            }
        }
    }

    public func DismissKeyboard(){
        self.view.endEditing(true)
    }

    func tapGesture() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.DismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.utf16.count == 1 {
            switch textField{
            case firstTxt:
                secondTxt.becomeFirstResponder()
            case secondTxt:
                thirdTxt.becomeFirstResponder()
            case thirdTxt:
                fourthTxt.becomeFirstResponder()
            case fourthTxt:
                fourthTxt.resignFirstResponder()
            default:
                break
            }
        }else if text?.utf16.count == 12 {
            switch textField{
            case mobileNoTxt:
                mobileNoTxt.resignFirstResponder()
                otpViews.isHidden = false
                self.savemobileanduuid()
                NetworkManager.postRequest(url: url, mobileNo: mobileNoTxt.text!, udid: deviceID)
            default:
                break
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstTxt || textField == secondTxt || textField == thirdTxt || textField == fourthTxt{
            scrollview.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        }else if textField == countryTxt {
            countryTxt.resignFirstResponder()
            openMenu.array(string: ["India", "United States of America (USA)","Virgin Islands (UK)", "Singapore", "Australia"])
            openMenu.openDropDown(tableHeight: 200)
            openMenu.countryCode = self

        }
        if mobileNoTxt.isTouchInside {
            countryTxt.isEnabled = false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileNoTxt || textField == firstTxt || textField == secondTxt || textField == thirdTxt || textField == fourthTxt {
            scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }

        countryTxt.isEnabled = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func validateDate(VmobileNo: String, Vudid: String, first: String, second: String, third: String, fouth: String) {
        let otpText:String = first + second + third + fouth
        print(otpText)
        let parameter = ["MobileNo": VmobileNo, "DeviceId": Vudid, "code":otpText]
        guard let url = URL(string:  "https://lzhohptp6i.execute-api.us-east-1.amazonaws.com/tarpanverficationapi") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let respon = response {
                print(respon)
            }
            if let data = data {
                print(data)
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    print(jsonData)
                    if let statusCode = jsonData["statusCode"] as? Int {
                        if statusCode == 404 {
                            let alert = UIAlertController(title: "Error", message: "Verification Failed", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Okey", style: .destructive)
                            alert.addAction(action)
                            self.view.hideLoadingView()
                            self.present(alert, animated: true, completion: nil)
                        }else {
                            let VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
                            VC?.mobile = self.mobileNoTxt.text!
                            VC?.uuid = self.deviceID
                            self.navigationController?.view.hideLoadingView()
                            DispatchQueue.main.async {
                                self.present(VC!, animated: true, completion: nil)
                            }
                        }
                    }
                }catch {
                    print(error)
                }
            }
        }.resume()
    }

    func savemobileanduuid() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Tarpan", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(mobileNoTxt.text, forKey: "mobileno")
        managedObject.setValue(deviceID, forKey: "uuid")
        
        do {
            try managedContext.save()
            tarpanArr.append(managedObject)
            print(managedObject)
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    public func performSugue(id: String) {
        self.performSegue(withIdentifier: id, sender: self)
    }
}


extension UserDefaults {

    func setString(string:String, forKey:String) {
        set(string, forKey: forKey)
    }
}
