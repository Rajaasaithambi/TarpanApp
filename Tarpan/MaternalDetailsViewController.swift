//
//  MaternalDetailsViewController.swift
//  Tarpan
//
//  Created by raja A on 8/24/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import CoreData

class MaternalDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var mothersGothram: FloatInputView!
    @IBOutlet var mothersFathersName: FloatInputView!
    @IBOutlet var mothersMothersName: FloatInputView!
    @IBOutlet var mothersGrandFathersName: FloatInputView!
    @IBOutlet var mothersGrandMothersName: FloatInputView!
    @IBOutlet var mothersGreateGrandFathersName: FloatInputView!
    @IBOutlet var mothersGreateGrandMothersName: FloatInputView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var yesNoBtn: UISegmentedControl!
    let url = "https://ouns4ls5rk.execute-api.us-east-1.amazonaws.com/tarpanmaternaldetails"
    var mobile = String()
    var uuid = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = false
        mothersGothram.textField.delegate = self
        mothersFathersName.textField.delegate = self
        mothersMothersName.textField.delegate = self
        mothersGrandFathersName.textField.delegate = self
        mothersGrandMothersName.textField.delegate = self
        mothersGreateGrandFathersName.textField.delegate = self
        mothersGreateGrandMothersName.textField.delegate = self
        mothersGothram.isHidden = true
        mothersFathersName.isHidden = true
        mothersMothersName.isHidden = true
        mothersGrandFathersName.isHidden = true
        mothersGrandMothersName.isHidden = true
        mothersGreateGrandFathersName.isHidden = true
        mothersGreateGrandMothersName.isHidden = true
        fetch()

        if Reachability.isConnectedToNetwork() == true {
            print("Internet Connection Available!")
        }else {
            let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okey", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func yesNoBtnACT(_ sender: UISegmentedControl) {

        if yesNoBtn.selectedSegmentIndex == 0 {
//            let checkVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CheckListController") as? CheckListController
//            self.navigationController?.pushViewController(checkVC!, animated: true)
            mothersGothram.isHidden = true
            mothersFathersName.isHidden = true
            mothersMothersName.isHidden = true
            mothersGrandFathersName.isHidden = true
            mothersGrandMothersName.isHidden = true
            mothersGreateGrandFathersName.isHidden = true
            mothersGreateGrandMothersName.isHidden = true
        }else {
            mothersGothram.isHidden = false
            mothersFathersName.isHidden = false
            mothersMothersName.isHidden = false
            mothersGrandFathersName.isHidden = false
            mothersGrandMothersName.isHidden = false
            mothersGreateGrandFathersName.isHidden = false
            mothersGreateGrandMothersName.isHidden = false
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mothersMothersName.textField {
            scrollView.setContentOffset(CGPoint(x: 0, y: 60), animated: true)
        }else if textField == mothersGrandMothersName.textField {
            scrollView.setContentOffset(CGPoint(x: 0, y: 120), animated: true)
        }else if textField == mothersGreateGrandMothersName.textField {
            scrollView.setContentOffset(CGPoint(x: 0, y: 180), animated: true)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mothersGrandMothersName.textField || textField == mothersGreateGrandMothersName.textField || textField == mothersMothersName.textField {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func saveDetailsBtn(_ sender: UIButton) {
        self.validate()
    }

    func validate() {
    if (mothersGothram.textField.text?.isEmpty)! {
        alert(Constants.Messages.mothersGotram.title, message: Constants.Messages.mothersGotram.message)
     }else if (mothersFathersName.textField.text?.isEmpty)!{
        alert(Constants.Messages.mothersFatherName.title, message: Constants.Messages.mothersFatherName.message)
    }else if (mothersMothersName.textField.text?.isEmpty)! {
        alert(Constants.Messages.mothersName.title, message: Constants.Messages.mothersName.message)
    }else if (mothersGrandFathersName.textField.text?.isEmpty)!{
        alert(Constants.Messages.mothersgrandFatherName.title, message: Constants.Messages.mothersgrandFatherName.message)
    }else if (mothersGrandMothersName.textField.text?.isEmpty)!{
        alert(Constants.Messages.mothersgrandMotherName.title, message: Constants.Messages.mothersgrandMotherName.message)
    }else if (mothersGreateGrandFathersName.textField.text?.isEmpty)!{
        alert(Constants.Messages.mothersgreategrandFatherName.title, message: Constants.Messages.mothersgreategrandFatherName.message)
    }else if (mothersGreateGrandMothersName.textField.text?.isEmpty)! {
        alert(Constants.Messages.mothersgreategrandMotherName.title, message: Constants.Messages.mothersgreategrandMotherName.message)
    }else {
    let gotram = self.mothersGothram.textField.text
    let mothersFathersName1 = self.mothersFathersName.textField.text
    let mothersName1 = self.mothersMothersName.textField.text
    let mothersGrandFathersName1 = self.mothersGrandFathersName.textField.text
    let mothersGrandMothersName1 = self.mothersGrandMothersName.textField.text
    let mothersGreateGrandFathersName1 = self.mothersGreateGrandFathersName.textField.text
    let mothersGreateGrandMothersName1 = self.mothersGreateGrandMothersName.textField.text
    let gotramValidate = isValidName(name: gotram!)
    let fathersMothernameValidate = isValidName(name: mothersName1!)
    let fathersGrandFatherNameValidate = isValidName(name:mothersGrandFathersName1!)
    let fathersGrandMotherNameValidate = isValidName(name:mothersGrandMothersName1!)
    let fathersGreateGrandFatherNameValidate = isValidName(name: mothersGreateGrandFathersName1!)
    let fathersGreateGrandMotherNameValidate = isValidName(name: mothersGreateGrandMothersName1!)
    let fatherFatherNameValidate = isValidName(name: mothersFathersName1!)
    if gotramValidate {
        if fatherFatherNameValidate {
            if fathersMothernameValidate {
                if fathersGrandFatherNameValidate {
                    if fathersGrandMotherNameValidate {
                        if fathersGreateGrandFatherNameValidate {
                            if fathersGreateGrandMotherNameValidate {
                                if Reachability.isConnectedToNetwork() == true {
                                    self.navigationController?.view.showLoadingView()
                                    DispatchQueue.main.async {
                                        NetworkManager.postUserPreference1(url: self.url, mobileNo: self.mobile, udid: self.uuid, isYourMotherOrFatherAlive: self.yesNoBtn.isSelected, mothersGothram: gotram!, mothersFathersName: mothersFathersName1!, mothersGrandFatherName: mothersGrandFathersName1!, mothersGreatGrandFatherName: mothersGreateGrandFathersName1!, mothersName: mothersName1!, mothersGrandMotherName: mothersGrandMothersName1!, mothersGreatGrandMotherName: mothersGreateGrandMothersName1!)
                                        self.mothersGothram.textField.text = ""
                                        self.mothersFathersName.textField.text = ""
                                        self.mothersMothersName.textField.text = ""
                                        self.mothersGrandFathersName.textField.text = ""
                                        self.mothersGrandMothersName.textField.text = ""
                                        self.mothersGreateGrandFathersName.textField.text = ""
                                        self.mothersGreateGrandMothersName.textField.text = ""
                                        self.navigationController?.view.hideLoadingView()
                                    }
                                }else {
                                    let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "Okey", style: .default)
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }else {
                                alert(Constants.Messages.greateGrandMotherNameValidate.title, message: Constants.Messages.greateGrandMotherNameValidate.message)
                            }
                        }else {
                            alert(Constants.Messages.greateGrandFatherNameValidate.title, message: Constants.Messages.greateGrandFatherNameValidate.message)
                        }
                    }else {
                        alert(Constants.Messages.grandMotherNameValidate.title, message: Constants.Messages.grandMotherNameValidate.message)
                    }
                }else {
                    alert(Constants.Messages.grandFatherNameValidate.title, message: Constants.Messages.grandFatherNameValidate.message)
                    }
                }else {
                    alert(Constants.Messages.motherNameValidate.title, message: Constants.Messages.motherNameValidate.message)
                }
            }else {
                alert(Constants.Messages.fatherNameValidate.title, message: Constants.Messages.fatherNameValidate.message)
            }
                }else {
            alert(Constants.Messages.gotramValidate.title, message: Constants.Messages.gotramValidate.message)
            }
        }
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
            uuid = (res.value(forKey: "uuid") as? String)!
        }
    }
}

