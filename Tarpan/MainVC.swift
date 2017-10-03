//
//  MainVC.swift
//  Tarpan
//
//  Created by raja A on 9/28/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import  UserNotifications

class MainVC: UIViewController {


    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!


    let blackColor = UIColor(colorWithHexValue: 0x000000)
    let redColour = UIColor(colorWithHexValue: 0xFF4C00)
    let titleTintColor = UIColor(colorWithHexValue: 0xffffff)

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn() {
            perform(#selector(MainVC.showHomePage), with: nil, afterDelay: 0.01)
        }else {
            perform(#selector(MainVC.showLoginViewController), with: nil, afterDelay: 0.01)
        }
        localPushNotification()
    }

    public func localPushNotification() {
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let yes = UNNotificationAction(identifier: "yes", title: "Yes", options: .foreground)
        let no =  UNNotificationAction(identifier: "no", title: "No", options: .foreground)
        let category = UNNotificationCategory(identifier: "cat", actions: [yes, no], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        //Set your content
        let content = UNMutableNotificationContent()
        content.title = "Tarpan"
        content.body = "Horoscope is updated"
        content.categoryIdentifier = "cat"

        let request = UNNotificationRequest(
            identifier: "yourIdentifier", content: content, trigger: trigger
        )
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    func showLoginViewController() {
        let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.present(loginVC!, animated: true, completion: nil)
    }

    func showHomePage() {
        let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? CollectionView
        self.present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func signIn_signUpBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 1 {
            self.radioBtn()
            signUpBtn.backgroundColor = titleTintColor
            signUpBtn.setTitleColor(blackColor, for: .normal)
            let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            self.present(loginVC!, animated: true, completion: nil)
        }else if sender.tag == 2 {
            self.radioBtn()
            signInBtn.backgroundColor = titleTintColor
            signInBtn.setTitleColor(blackColor, for: .normal)
            let initialVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
            self.present(initialVC!, animated: true, completion: nil)
        }
    }

    func radioBtn() {
        if signInBtn.isSelected {
            signInBtn.backgroundColor = redColour
            signInBtn.setTitleColor(titleTintColor, for: .normal)
            signInBtn.isSelected = false
        }else if signUpBtn.isSelected {
            signUpBtn.backgroundColor = redColour
            signUpBtn.setTitleColor(titleTintColor, for: .normal)
            signUpBtn.isSelected = false
        }
    }

}
