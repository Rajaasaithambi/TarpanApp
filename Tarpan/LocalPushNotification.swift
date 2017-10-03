//
//  LocalPushNotification.swift
//  Tarpan
//
//  Created by raja A on 9/27/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotification: UIViewController{

    struct Notification {

        struct Category {
            static let tutorial = "Tarpan"
        }

        struct Action {
            static let readLater = "readLater"
            static let showDetails = "showDetails"
            //static let unsubscribe = "unsubscribe"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        didCall()
    }

   private func didCall() {

        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }

                    // Schedule Local Notification
                    self.scheduleLocalNotification()
                })
            case .authorized:
                // Schedule Local Notification
                self.scheduleLocalNotification()
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
    }

    func scheduleLocalNotification() {
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 47
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        //Set your content
        let content = UNMutableNotificationContent()
        content.title = "Tarpan"
        content.subtitle = "Horoscope Notification"
        content.body = "Daily Horoscope details."
        content.categoryIdentifier = Notification.Category.tutorial

        let request = UNNotificationRequest(
            identifier: "yourIdentifier", content: content, trigger: trigger
        )
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }

    func configureUserNotificationsCenter() {
        // Configure User Notification Center
        UNUserNotificationCenter.current().delegate = self

        // Define Actions
        let actionReadLater = UNNotificationAction(identifier: Notification.Action.readLater, title: "Read Later", options: [])
        let actionShowDetails = UNNotificationAction(identifier: Notification.Action.showDetails, title: "Show Details", options: [.foreground])
        //let actionUnsubscribe = UNNotificationAction(identifier: Notification.Action.unsubscribe, title: "Unsubscribe", options: [.destructive, .authenticationRequired])

        // Define Category
        let tutorialCategory = UNNotificationCategory(identifier: Notification.Category.tutorial, actions: [actionReadLater, actionShowDetails], intentIdentifiers: [], options: [])

        // Register Category
        UNUserNotificationCenter.current().setNotificationCategories([tutorialCategory])
    }

     func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }

            completionHandler(success)
        }
    }
}


extension LocalNotification: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Notification.Action.readLater:
            print("Save Tutorial For Later")
            let horoscopeVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HoroscopeViewController") as? HoroscopeViewController
            self.present(horoscopeVC!, animated: true, completion: nil)
//        case Notification.Action.unsubscribe:
//            print("Unsubscribe Reader")
        default:
            print("Other Action")
        }

        completionHandler()
    }
}


class CountryPhoneCodeAndName: NSObject {
    var countryWithCode = [CountryNameWithCode]()

    var countryDictionary = ["US":"1", "IN":"91", "SG":"65", "AU":"61", "JP":"81", "UA":"380", "CH":"41"]

    func getCountryName() {
        // Sorting all keys
        let keys = countryDictionary.keys
        let keysValue = keys.sorted { (first, second) -> Bool in
            let key1: String = first
            let key2: String = second
            let result = key1.compare(key2) == .orderedAscending
            return result

        }
        print(keysValue)

        for key in keysValue{
            let countryKeyValue = CountryNameWithCode()
            print(countryDictionary[key] ?? "not")
            countryKeyValue.countryCode = countryDictionary[key]!
            countryKeyValue.countryName = Locale.current.localizedString(forRegionCode: key)!
            print(Locale.current.localizedString(forRegionCode: key)!)
            countryWithCode.append(countryKeyValue)
        }
    }

    class CountryNameWithCode: NSObject {
        var countryName = ""
        var countryCode = ""
        
    }  
}


