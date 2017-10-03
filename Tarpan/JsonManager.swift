//
//  JsonManager.swift
//  Tarpan
//
//  Created by raja A on 9/19/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import Foundation
import UIKit


class NetworkManager: NSObject {

    class func getData(url: String, tableview: UITableView) {
        var horArr = [HoroscopeDescription]()
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)

        let dataTask = session.dataTask(with: URL.init(string: url)!) { (data, response, error) in
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                let horoscpeDes = HoroscopeDescription()
                if let horoscope = jsonResult["horoscope"] as? String , let date = jsonResult["date"] as? String {
                    horoscpeDes.horosDes = horoscope
                    horoscpeDes.date = date
                }
                horArr.append(horoscpeDes)

                DispatchQueue.main.async {
                    tableview.reloadData()
                }
            } catch  {
                print ("Error")
            }
        }
        dataTask.resume()
    }

    class func postRequest(url: String, mobileNo: String, udid: String) {
        let parameter = ["MobileNo": mobileNo, "DeviceId": udid ]
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
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonData)
                    }catch {
                        print(error)
                }
            }
        }.resume()
    }


    class func postBasicDetails(url: String, mobileNo: String, udid:String, country: String, caste: String, veaam: String , suthram: String) {
        let parameter = ["MobileNo": mobileNo, "DeviceId": udid, "Info":["Country": country, "Caste": caste, "Veaam": veaam, "Suthram":suthram]] as [String : Any]
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
                    print(jsonData ?? "454")
                    if let statusCode = jsonData?["statusCode"] as? Int {
                        if statusCode == 404 {
                            print(statusCode)
                        }else {
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TarpanProcedureController") as? TarpanProcedureController
                            UIApplication.shared.keyWindow?.rootViewController?.navigationController?.view.hideLoadingView()
                            DispatchQueue.main.async {
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.window?.rootViewController = vc
                            }
                        }
                    }

                }catch {
                    print(error)
                }
            }
        }.resume()
    }


    class func postUserPreference(url: String, mobileNo: String, udid:String, fathersGothram: String, fathersName: String, fathersGrandFatherName: String , isYourMotherAlive: Bool, fathersMotherName: String, fathersGrandMotherName: String, fathersGreatGrandMotherName: String, mothersName: String) {
        let parameter = ["MobileNo": mobileNo, "DeviceId": udid, "Info":["FathersGothram": fathersGothram, "FathersName": fathersName, "FathersGrandFatherName": fathersGrandFatherName, "IsYourMotherAlive":isYourMotherAlive, "FathersMotherName": fathersMotherName  , "FathersGrandMotherName": fathersGrandMotherName, "FathersGreatGrandMotherName": fathersGreatGrandMotherName, "MothersName": mothersName]] as [String : Any]
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
                    print(jsonData!)
                    if let statusCode = jsonData?["statusCode"] as? Int {
                        if statusCode == 404 {
                            print(statusCode)

                        }else {
                            let VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MaternalDetailsViewController") as? MaternalDetailsViewController
                            UIApplication.shared.keyWindow?.rootViewController?.navigationController?.view.hideLoadingView()
                            DispatchQueue.main.async {
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.window?.rootViewController = VC
                            }
                        }
                    }

                }catch {
                    print(error)
                }
            }
            }.resume()
    }

    class func postUserPreference1(url: String, mobileNo: String, udid:String, isYourMotherOrFatherAlive: Bool, mothersGothram: String, mothersFathersName: String, mothersGrandFatherName: String ,  mothersGreatGrandFatherName: String, mothersName: String, mothersGrandMotherName: String, mothersGreatGrandMotherName: String) {
        let parameter = ["MobileNo": mobileNo, "DeviceId": udid, "Info":["IsYourMotherOrFatherAlive": isYourMotherOrFatherAlive, "MothersGothram": mothersGothram, "MothersFathersName": mothersFathersName, "MothersGrandFatherName":mothersGrandFatherName, "MothersGreatGrandFatherName": mothersGreatGrandFatherName, "MothersName": mothersName, "MothersGrandMotherName": mothersGrandMotherName, "MothersGreatGrandMotherName": mothersGreatGrandMotherName]] as [String : Any]
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
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonData)
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
}


extension UIViewController {

    func presentAction() {
       self.performSegue(withIdentifier: "home", sender: self)
    }
}

