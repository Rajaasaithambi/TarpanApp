//
//  PaternalDetailsViewController.swift
//  Tarpan
//
//  Created by raja A on 8/24/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import CoreData

var tarpanArr1 = [NSManagedObject]()
var mobile = String()
var uuid = String()

class PaternalDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var fathersGothram: FloatInputView!
    @IBOutlet var fathersName: FloatInputView!
    @IBOutlet var fathersFatherName: FloatInputView!
    @IBOutlet var fathersGrandFatherName  : FloatInputView!
    @IBOutlet var MothersName: FloatInputView!
    @IBOutlet var fathersMotherName: FloatInputView!
    @IBOutlet var fathersGrandMotherName: FloatInputView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var yesNoBtn: UISegmentedControl!
    let url = "https://falaoa3c2i.execute-api.us-east-1.amazonaws.com/tarpanuserpreference"


    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.isScrollEnabled = false
        fathersGothram.textField.delegate = self
        fathersName.textField.delegate = self
        fathersFatherName.textField.delegate = self
        fathersMotherName.textField.delegate = self
        fathersGrandMotherName.textField.delegate = self
        fathersGrandFatherName.textField.delegate = self
        MothersName.textField.delegate = self
        MothersName.isHidden = true
        fathersMotherName.isHidden = true
        fathersGrandMotherName.isHidden = true
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
            MothersName.isHidden = false
            fathersMotherName.isHidden = false
            fathersGrandMotherName.isHidden = false
            MothersName.placeHolderStringKey = "Father's Mother Name"
            fathersMotherName.placeHolderStringKey = "Father's Grand Mother Name"
            fathersGrandMotherName.placeHolderStringKey = "Father's Great Grand Mother Name"

        }else {
            MothersName.isHidden = false
            fathersMotherName.isHidden = false
            fathersGrandMotherName.isHidden = false
            MothersName.placeHolderStringKey = "Mother's Name"
            fathersMotherName.placeHolderStringKey = "Father's Mother Name"
            fathersGrandMotherName.placeHolderStringKey = "Father's Grand Mother Name"
        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == MothersName.textField{
                scrollView.setContentOffset(CGPoint(x: 0, y: 30), animated: true)
            }else if textField == fathersGrandMotherName.textField {
                scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
            }else if textField == fathersMotherName.textField {
                scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == fathersGrandMotherName.textField || textField == fathersMotherName.textField || textField == MothersName.textField{
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func saveDetailsBtn(_ sender: UIButton) {
        validate()
    }

    @IBAction func dismissPD(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func validate() {
        if (fathersGothram.textField.text?.isEmpty)! {
            alert(Constants.Messages.fathersGotram.title, message: Constants.Messages.fathersGotram.message)
        }else if (fathersName.textField.text?.isEmpty)!{
            alert(Constants.Messages.fathersFatherName.title, message: Constants.Messages.fathersFatherName.message)
        }else if (fathersFatherName.textField.text?.isEmpty)! {
            alert(Constants.Messages.fathersMotherName.title, message: Constants.Messages.fathersMotherName.message)
        }else if (fathersGrandFatherName.textField.text?.isEmpty)!{
            alert(Constants.Messages.fathersgrandFatherName.title, message: Constants.Messages.fathersgrandFatherName.message)
        }else if yesNoBtn != nil {
            if yesNoBtn.selectedSegmentIndex == 0 {
                if (MothersName.textField.text?.isEmpty)!{
                    alert(Constants.Messages.fathersMotherName.title, message: Constants.Messages.fathersMotherName.message)
                }else if (fathersMotherName.textField.text?.isEmpty)!{
                    alert(Constants.Messages.fathersgrandMotherName.title, message: Constants.Messages.fathersgrandMotherName.message)
                }else if (fathersGrandMotherName.textField.text?.isEmpty)! {
                    alert(Constants.Messages.fathersgreategrandMotherName.title, message: Constants.Messages.fathersgreategrandMotherName.message)
                }
            }else {
                if (MothersName.textField.text?.isEmpty)!{
                    alert(Constants.Messages.mothersName.title, message: Constants.Messages.mothersName.message)
                }else if (fathersMotherName.textField.text?.isEmpty)!{
                    alert(Constants.Messages.fathersMotherName.title, message: Constants.Messages.fathersMotherName.message)
                }else if (fathersGrandMotherName.textField.text?.isEmpty)! {
                    alert(Constants.Messages.fathersgrandMotherName.title, message: Constants.Messages.fathersgrandMotherName.message)
                }
            }
        }//else {
            let gotram = self.fathersGothram.textField.text
            let fathersName1 = self.fathersName.textField.text
            let fathersFathersName1 = self.fathersFatherName.textField.text
            let fathersGrandFathersName1 = self.fathersGrandFatherName.textField.text
            let MothersName1 = self.MothersName.textField.text
            let fathersMotherName1 = self.fathersMotherName.textField.text
            let fathersGrandMotherName1 = self.fathersGrandMotherName.textField.text
            let gotramValidate = isValidName(name: gotram!)
            let fathersMothernameValidate = isValidName(name: fathersName1!)
            let fathersGrandFatherNameValidate = isValidName(name:fathersFathersName1!)
            let fathersGrandMotherNameValidate = isValidName(name:fathersGrandFathersName1!)
            let fathersGreateGrandFatherNameValidate = isValidName(name: MothersName1!)
            let fathersGreateGrandMotherNameValidate = isValidName(name: fathersMotherName1!)
            let fatherFatherNameValidate = isValidName(name: fathersGrandMotherName1!)
            if gotramValidate {
                if fatherFatherNameValidate {
                    if fathersMothernameValidate {
                        if fathersGrandFatherNameValidate {
                            if fathersGrandMotherNameValidate {
                                if fathersGreateGrandFatherNameValidate {
                                    if fathersGreateGrandMotherNameValidate {
                                        if Reachability.isConnectedToNetwork() == true {
                                            self.navigationController?.view.showLoadingView()
                                            DispatchQueue.main.async{
                                                NetworkManager.postUserPreference(url: self.url, mobileNo: mobile, udid: uuid, fathersGothram: gotram!, fathersName: fathersName1!, fathersGrandFatherName: fathersGrandFathersName1!, isYourMotherAlive: self.yesNoBtn.isSelected, fathersMotherName: fathersMotherName1!, fathersGrandMotherName: fathersGrandMotherName1!, fathersGreatGrandMotherName: fathersMotherName1!, mothersName: MothersName1!)
                                                self.fathersGothram.textField.text = ""
                                                self.fathersName.textField.text = ""
                                                self.fathersFatherName.textField.text = ""
                                                self.fathersMotherName.textField.text = ""
                                                self.fathersGrandMotherName.textField.text = ""
                                                self.fathersGrandFatherName.textField.text = ""
                                                self.MothersName.textField.text = ""
                                            }
                                        }else {
                                            let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
                                            let action = UIAlertAction(title: "Okey", style: .default)
                                            alert.addAction(action)
                                            self.present(alert, animated: true, completion: nil)
                                        }

                                    }else {
                                        alert(Constants.Messages.greateGrandMotherNameValidate1.title, message: Constants.Messages.greateGrandMotherNameValidate1.message)
                                    }
                                }else {
                                    alert(Constants.Messages.greateGrandFatherNameValidate1.title, message: Constants.Messages.greateGrandFatherNameValidate1.message)
                                }
                            }else {
                                alert(Constants.Messages.grandMotherNameValidate1.title, message: Constants.Messages.grandMotherNameValidate1.message)
                            }
                        }else {
                            alert(Constants.Messages.grandFatherNameValidate1.title, message: Constants.Messages.grandFatherNameValidate1.message)
                        }
                    }else {
                        alert(Constants.Messages.motherNameValidate1.title, message: Constants.Messages.motherNameValidate1.message)
                    }
                }else {
                    alert(Constants.Messages.fatherNameValidate1.title, message: Constants.Messages.fatherNameValidate1.message)
                }
            }else {
                alert(Constants.Messages.gotramValidate1.title, message: Constants.Messages.gotramValidate1.message)
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
            print(mobile)
            uuid = (res.value(forKey: "uuid") as? String)!
            print(uuid)
        }
    }
