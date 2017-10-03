//
//  BasicDetailsViewController.swift
//  Tarpan
//
//  Created by raja A on 8/24/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import CoreData

class BasicDetailsViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var SuthramTxt: UITextField!
    @IBOutlet var countryListTxt: UITextField!
    @IBOutlet var iyerBtn: UIButton!
    @IBOutlet var iyengarBtn: UIButton!
    @IBOutlet var teluguBtn: UIButton!
    @IBOutlet var othersBtn: UIButton!
    @IBOutlet var rigBtn: UIButton!
    @IBOutlet var yajurBtn: UIButton!
    @IBOutlet var sameBtn: UIButton!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    @IBOutlet var fourthView: UIView!
    let screenSize:CGRect = UIScreen.main.bounds
    let blackColor = UIColor(colorWithHexValue: 0x000000)
    let redColour = UIColor(colorWithHexValue: 0xFF4C00)
    let titleTintColor = UIColor(colorWithHexValue: 0xffffff)
    let popover = DropMenu()
    let pop = Dropdown()
    var suthramArray = [String]()
    var button = UIButton()
    var btn = CollectionView()
    let url = "https://8qoec9ilmc.execute-api.us-east-1.amazonaws.com/tarpanbasicdetails"
    var casteData = String()
    var tarpanArr1 = [NSManagedObject]()
    var mobile = String()
    var uuid = String()
    @IBOutlet var vedamLab: UILabel!
    @IBOutlet var casteLab: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryListTxt.delegate = self
        SuthramTxt.delegate = self
        thirdView.isHidden = true
        fourthView.isHidden = true
        countryListTxt.text = "United States of America (USA)"
        //btn.createBarBtn(imageName: "")
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

    @IBAction func didPressedBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 1 {
            self.radioBtn()
            iyengarBtn.titleLabel?.textColor = blackColor
            teluguBtn.titleLabel?.textColor = blackColor
            iyengarBtn.backgroundColor = titleTintColor
            teluguBtn.backgroundColor = titleTintColor
            othersBtn.backgroundColor = titleTintColor
            othersBtn.titleLabel?.textColor = blackColor
            let value = iyerBtn.titleLabel?.text
            casteLab.text = value!

        }else if sender.tag == 2 {
            self.radioBtn()
            iyerBtn.titleLabel?.textColor = blackColor
            teluguBtn.titleLabel?.textColor = blackColor
            iyerBtn.backgroundColor = titleTintColor
            teluguBtn.backgroundColor = titleTintColor
            othersBtn.backgroundColor = titleTintColor
            othersBtn.titleLabel?.textColor = blackColor
            iyengarBtn.titleLabel?.text = casteData
            let value = iyengarBtn.titleLabel?.text
            casteLab.text = value!
        }else if sender.tag == 3 {
            self.radioBtn()
            iyerBtn.titleLabel?.textColor = blackColor
            iyengarBtn.titleLabel?.textColor = blackColor
            iyerBtn.backgroundColor = titleTintColor
            iyengarBtn.backgroundColor = titleTintColor
            othersBtn.backgroundColor = titleTintColor
            othersBtn.titleLabel?.textColor = blackColor
            teluguBtn.titleLabel?.text = casteData
            let value = teluguBtn.titleLabel?.text
            casteLab.text = value!
        }else if sender.tag == 5 {
            self.radioBtn()
            sameBtn.titleLabel?.textColor = blackColor
            sameBtn.backgroundColor = titleTintColor
            yajurBtn.titleLabel?.textColor = blackColor
            yajurBtn.backgroundColor = titleTintColor
            let value = yajurBtn.titleLabel?.text
            vedamLab.text = value!
        }else if sender.tag == 6 {
            self.radioBtn()
            rigBtn.titleLabel?.textColor = blackColor
            rigBtn.backgroundColor = titleTintColor
            sameBtn.titleLabel?.textColor = blackColor
            sameBtn.backgroundColor = titleTintColor
            let value = sameBtn.titleLabel?.text
            vedamLab.text = value!
        }else if sender.tag == 7 {
            self.radioBtn()
            rigBtn.titleLabel?.textColor = blackColor
            rigBtn.backgroundColor = titleTintColor
            yajurBtn.titleLabel?.textColor = blackColor
            yajurBtn.backgroundColor = titleTintColor
            let value = rigBtn.titleLabel?.text
            vedamLab.text = value!
        }else if sender.tag == 4 {
            self.radioBtn()
            iyengarBtn.titleLabel?.textColor = blackColor
            teluguBtn.titleLabel?.textColor = blackColor
            iyengarBtn.backgroundColor = titleTintColor
            teluguBtn.backgroundColor = titleTintColor
            iyerBtn.titleLabel?.textColor = blackColor
            iyerBtn.backgroundColor = titleTintColor
            othersBtn.titleLabel?.text = casteData
            let value = othersBtn.titleLabel?.text
            casteLab.text = value!
        }
    }

    func radioBtn() {

            if iyerBtn.isSelected {
                iyerBtn.backgroundColor = redColour
                iyerBtn.setTitleColor(titleTintColor, for: .normal)
                iyerBtn.isSelected = false
                thirdView.isHidden = false
            }else if iyengarBtn.isSelected {
                iyengarBtn.backgroundColor = redColour
                iyengarBtn.setTitleColor(titleTintColor, for: .normal)
                iyengarBtn.isSelected = false
                thirdView.isHidden = false
            }else if teluguBtn.isSelected {
                teluguBtn.backgroundColor = redColour
                teluguBtn.setTitleColor(titleTintColor, for: .normal)
                teluguBtn.isSelected = false
                thirdView.isHidden = false
            }else if rigBtn.isSelected {
                fourthView.isHidden = false
                popover.array(string: ["Asvalayana", "Sankhayana", "Saunaka"])
                rigBtn.backgroundColor = redColour
                rigBtn.setTitleColor(titleTintColor, for: .normal)
                rigBtn.isSelected = false
            }else if yajurBtn.isSelected {
                fourthView.isHidden = false
                popover.array(string: ["Apastamba", "Baudhayana", "Bharadvaja", "Kaundinya", "Satyasadha"])
                yajurBtn.backgroundColor = redColour
                yajurBtn.setTitleColor(titleTintColor, for: .normal)
                yajurBtn.isSelected = false
            }else if sameBtn.isSelected {
                fourthView.isHidden = false
                popover.array(string:["Drahyayana", "Latyayana", "Saunaka"])
                sameBtn.backgroundColor = redColour
                sameBtn.setTitleColor(titleTintColor, for: .normal)
                sameBtn.isSelected = false
            }else if othersBtn.isSelected {
                othersBtn.backgroundColor = redColour
                othersBtn.setTitleColor(titleTintColor, for: .normal)
                othersBtn.isSelected = false
                thirdView.isHidden = true
                fourthView.isHidden = true
                rigBtn.titleLabel?.textColor = blackColor
                rigBtn.backgroundColor = titleTintColor
                sameBtn.titleLabel?.textColor = blackColor
                sameBtn.backgroundColor = titleTintColor
                yajurBtn.titleLabel?.textColor = blackColor
                yajurBtn.backgroundColor = titleTintColor
            }
    }

    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveDetailsBtn(_ sender: UIButton) {
        self.validation()
        print("caste:",casteLab.text!)
        print("Vedam:", vedamLab.text!)
    }

    func createBtn() {
        button = UIButton(type: .custom)
    }

    func validation() {
        if (countryListTxt.text?.isEmpty)! || (iyerBtn.titleLabel?.text?.isEmpty)! || (iyengarBtn.titleLabel?.text?.isEmpty)! || (teluguBtn.titleLabel?.text?.isEmpty)! || (othersBtn.titleLabel?.text?.isEmpty)!||(rigBtn.titleLabel?.text?.isEmpty)! || (yajurBtn.titleLabel?.text?.isEmpty)! || (sameBtn.titleLabel?.text?.isEmpty)! || (SuthramTxt.text?.isEmpty)!{
            alert(Constants.Messages.TextFieldEmpty.title, message: Constants.Messages.TextFieldEmpty.message)
        }else {
            if Reachability.isConnectedToNetwork() == true {
                self.navigationController?.view.showLoadingView()
                DispatchQueue.main.async{
                    NetworkManager.postBasicDetails(url: self.url, mobileNo: self.mobile, udid: self.uuid, country: self.countryListTxt.text!, caste: self.casteLab.text!, veaam: self.vedamLab.text!, suthram: self.SuthramTxt.text!)
                }
            }else {
                let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okey", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if DeviceType.IS_IPAD {
            if textField == countryListTxt {
                countryListTxt.resignFirstResponder()
                self.performSegue(withIdentifier: "popover", sender: self)
            }
        }else if DeviceType.IS_IPHONE_6P || DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_5 {
            if textField == countryListTxt {
                countryListTxt.resignFirstResponder()
                popover.array(string: ["India", "United States of America (USA)", "Virgin Islands (UK)", "Singapore", "China", "Japan", "Ireland","Israel","Italy", "Botswana","Brazil","Brunei","Bulgaria","Burkina Faso","Burundi"])
                popover.openDropDown(tableHeight: 300)
                popover.countrySelected = self

            }else if textField == SuthramTxt {
                SuthramTxt.resignFirstResponder()
                popover.openDropDown(tableHeight: 130)
                popover.suthramSelected = self
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover" {
            let dest = segue.destination
            if let pop = dest.popoverPresentationController {
                pop.preferredContentSize.equalTo(CGSize(width: 0, height: 0))
                pop.delegate = self
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: 100, y: 150, width: 0, height: 0)
            }
            let vc = segue.destination as? Dropdown
            vc?.basicDetailsView = self
        }
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
            self.mobile = (res.value(forKey: "mobileno") as? String)!
            print(mobile)
            self.uuid = (res.value(forKey: "uuid") as? String)!
            print(uuid)
        }
    }
}

extension UIColor {

    convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((value & 0x0000FF)) / 255.0,
            alpha:alpha
        )
    }
}
