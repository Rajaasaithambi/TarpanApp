//
//  LoginViewController.swift
//  Tarpan
//
//  Created by raja A on 8/22/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emailTxt: FloatInputView!
    @IBOutlet var mobileTxt: FloatInputView!
    let url = "https://09an9urckl.execute-api.us-east-1.amazonaws.com/tarpanlogin"
    var deviceID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.textField.isSecureTextEntry = true
        emailTxt.textField.delegate = self
        mobileTxt.textField.delegate = self
        mobileTxt.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        emailTxt.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.tapGesture()
        deviceID = UIDevice.current.identifierForVendor!.uuidString
    }

    func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if text?.utf16.count == 4 {
            switch textField {
            case emailTxt.textField:
                emailTxt.textField.resignFirstResponder()
            default:
                break
            }
        }else if text?.utf16.count == 12{
            switch textField{
            case mobileTxt.textField:
                emailTxt.textField.becomeFirstResponder()
            default:
                break
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTxt.textField {
            scrollView.setContentOffset( CGPoint(x:0, y:0) , animated: true)
            emailTxt.textField.keyboardType = .numberPad
        }else {
            mobileTxt.textField.keyboardType = .numberPad
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileTxt.textField || textField == emailTxt.textField {
            scrollView.setContentOffset( CGPoint(x:0, y:0) , animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == mobileTxt.textField.text {
            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.characters.count <= maxLength
        }else if textField.text == emailTxt.textField.text {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.characters.count <= maxLength
        }
        return true
    }

    public func DismissKeyboard(){
        self.view.endEditing(true)
    }
    public func tapGesture() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.DismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    @IBAction func signUpBtn(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.present(vc!, animated: true, completion: nil)
    }

    @IBAction func loginBtn(_ sender: UIButton) {
        if (mobileTxt.textField.text?.isEmpty)!{
            alert(Constants.Messages.MobileFieldMissing.title, message: Constants.Messages.MobileFieldMissing.message)
        }else if (emailTxt.textField.text?.isEmpty)! {
            alert(Constants.Messages.passwordFieldMissing.title, message: Constants.Messages.passwordFieldMissing.message)
        }else {
            let mobNumber = mobileTxt.textField.text
            let password = emailTxt.textField.text
            if (mobNumber?.characters.count)! > 11 {
                let isValidateMobileNo = isValidatePhoneNo(phoneNumber: mobNumber!)
                if isValidateMobileNo {
                    if (password?.characters.count)! > 3 {
                        if Reachability.isConnectedToNetwork() == true {
                            self.view.showLoadingView()
                            DispatchQueue.main.async {
                                self.getCredencial(url: self.url, mobileNo: mobNumber!, password: password!, uuid: self.deviceID)
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
                    alert(Constants.Messages.InvalidMobile.title, message: Constants.Messages.InvalidMobile.message)
                }
            }else {
                alert(Constants.Messages.InvalidMobile.title, message: Constants.Messages.InvalidMobile.message)
            }
        }
    }

    func isValidateEmailTxt() {
        if !(emailTxt.textField.text?.isEmpty)!{
            let emailId = emailTxt.textField.text
            let isValidateEmailId = isValidEmail(testStr: emailId!)
            if isValidateEmailId {
                self.performSegue(withIdentifier: "home1", sender: self)
            }else {
                alert(Constants.Messages.InvalidEmail.title, message: Constants.Messages.InvalidEmail.message)
            }
        }
    }

    func getCredencial(url: String, mobileNo: String, password: String, uuid: String) {
        let parameter = ["MobileNo": mobileNo, "DeviceId": uuid, "Password": password]
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
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    print(jsonData!)
                    if let statusCode = jsonData?["statusCode"] as? Int {
                        if statusCode == 504 {
                            self.view.hideLoadingView()
                            let alert = UIAlertController(title: "Please Signup", message: "This Mobile Number is not registered.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Okey", style: .default, handler: { (action) in
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
                                self.present(vc!, animated: true, completion: nil)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }else if statusCode == 200 {
                            self.view.hideLoadingView()
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            UserDefaults.standard.synchronize()
                            self.performSegue(withIdentifier: "home1", sender: self)
                        }else if statusCode == 404 {
                            self.view.hideLoadingView()
                            let alert = UIAlertController(title: "Login Failed", message: "Invalid credential.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Okey", style: .destructive)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }else if statusCode == 300 {
                            self.view.hideLoadingView()
                            let alert = UIAlertController(title: "Please Signup", message: "This Device is not registered yet.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Okey", style: .default, handler: { (action) in
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
                                self.present(vc!, animated: true, completion: nil)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }

    func activityIndicator1() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    func dismiss() {
        dismiss(animated: false, completion: nil)
    }
}
