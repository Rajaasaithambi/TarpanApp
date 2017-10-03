//
//  RegisterViewController.swift
//  Tarpan
//
//  Created by raja A on 9/14/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTxt: FloatInputView!
    @IBOutlet var emailTxt: FloatInputView!
    @IBOutlet var passwordTxt: FloatInputView!
    @IBOutlet var scrollview: UIScrollView!
    var mobile = String()
    var uuid = String()
    let url = "https://badzbhstle.execute-api.us-east-1.amazonaws.com/tarpanbasicinfo"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxt.textField.delegate = self
        emailTxt.textField.delegate = self
        passwordTxt.textField.delegate = self
        passwordTxt.textField.isSecureTextEntry = true
        passwordTxt.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.tapGesture()
    }

    public func DismissKeyboard(){
        self.view.endEditing(true)
    }

    func tapGesture() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.DismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTxt.textField {
            scrollview.setContentOffset(CGPoint(x: 0, y: 20), animated: true)
        }else if textField == passwordTxt.textField {
            scrollview.setContentOffset(CGPoint(x: 0, y: 40), animated: true)
        }
        passwordTxt.textField.keyboardType = .numberPad
        nameTxt.textField.keyboardType = .namePhonePad
        emailTxt.textField.keyboardType = .emailAddress
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTxt.textField || textField == emailTxt.textField {
            scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }

    func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.utf16.count == 4 {
            passwordTxt.textField.resignFirstResponder()
        }
    }


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if textField.text == passwordTxt.textField.text {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.characters.count <= maxLength
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func saveBtn(_ sender: UIButton) {
        if (nameTxt.textField.text?.isEmpty)! {
            alert(Constants.Messages.nameFieldMissing.title, message: Constants.Messages.nameFieldMissing.message)
        }else if (emailTxt.textField.text?.isEmpty)! {
            alert(Constants.Messages.emailFieldMissing.title, message: Constants.Messages.emailFieldMissing.message)
        }else if (passwordTxt.textField.text?.isEmpty)! {
            alert(Constants.Messages.passwordFieldMissing.title, message: Constants.Messages.passwordFieldMissing.message)
        }else {
            let name = nameTxt.textField.text
            let email = emailTxt.textField.text
            let pass = passwordTxt.textField.text
            let ValidName = isValidName(name: name!)
            let checkEmailID = isValidEmail(testStr: email!)
            if ValidName {
                if checkEmailID {
                    if pass?.characters.count == 4 {
                        if Reachability.isConnectedToNetwork() == true {
                            self.view.showLoadingView()
                            DispatchQueue.main.async {
                                self.postBasicInfo(url: self.url, mobileNo: self.mobile, udid: self.uuid, username: name!, emailid: email!, password: pass!)
                            }
                        }else {
                            let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Okey", style: .default)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }else {
                        alert(Constants.Messages.Password.title, message: Constants.Messages.Password.message)
                    }
                }else {
                    alert(Constants.Messages.InvalidEmail.title, message: Constants.Messages.InvalidEmail.message)
                }
            }else {
                alert(Constants.Messages.InvalidName.title, message: Constants.Messages.InvalidName.message)
            }
        }
    }


    func postBasicInfo(url: String, mobileNo: String, udid:String, username: String, emailid: String, password: String) {
        let parameter = ["MobileNo": mobileNo, "DeviceId": udid, "Info":["UserName": username, "EmailId": emailid, "Password": password]] as [String : Any]
        guard let url = URL(string: url) else {
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
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let statusCode = jsonData?["statusCode"] as? Int {
                        if statusCode == 404 {
                            self.view.hideLoadingView()
                            
                        }else {
                            self.view.hideLoadingView()
                            DispatchQueue.main.async {
                                let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? CollectionView
                                self.present(loginVC!, animated: true, completion: nil)
                            }
                        }
                    }

                }catch {
                    print(error)
                }
            }
            }.resume()
    }

    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tarpan")
        do {
            tarpanArr1 = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        let results:NSArray = try! managedContext.fetch(fetchRequest) as NSArray
        if(results.count > 0){
            let res = results[0] as! NSManagedObject
            mobile = (res.value(forKey: "mobileno") as? String)!
            print(mobile)
            uuid = (res.value(forKey: "uuid") as? String)!
            print(uuid)
        }
    }
}
