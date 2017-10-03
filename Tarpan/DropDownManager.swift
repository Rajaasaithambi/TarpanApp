//
//  DropDownManager.swift
//  TrackTrace
//
//  Created by raja A on 8/17/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import Foundation
import UIKit


class DropMenu: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let fontSize = "BradleyHandITCTT-Bold"
    let dropView = UIView()
    let menuItemTable = UITableView()
    var selectedIndex = Int()
    var arrayOfSource = [String]()
    var alphabetic = [String]()
    var height = CGFloat()
    var countrySelected: BasicDetailsViewController?
    var suthramSelected: BasicDetailsViewController?
    var countryCode: SignUpVC?

    

    public func openDropDown(tableHeight: CGFloat) {
        if let window = UIApplication.shared.keyWindow {
            dropView.frame = window.frame
            dropView.backgroundColor = UIColor(white: 0, alpha: 0.5)
             height = tableHeight
            //dropView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissDropDown)))
            let y = window.frame.height - height
            menuItemTable.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(dropView)
            window.addSubview(menuItemTable)
            menuItemTable.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            UIView.animate(withDuration: 0.5, animations: { 
                self.dropView.alpha = 1
                self.menuItemTable.frame.origin.y = y
            })
        }
    }

    public func array(string: [String]) {
        arrayOfSource = string
        menuItemTable.reloadData()
        suthramSelected?.SuthramTxt.text = ""
    }

    public func dismissDropDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dropView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuItemTable.frame.origin.y = window.frame.height
            }
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alphabetic = arrayOfSource.sorted()
        return alphabetic.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuItemTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as UITableViewCell
        cell.textLabel?.text = alphabetic[indexPath.row]
        //cell.backgroundColor = UIColor(red:0.10, green:0.72, blue:0.69, alpha:1.0)
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let VC = countrySelected {
                VC.countryListTxt.text = alphabetic[indexPath.row]
                selectedIndex = indexPath.row
                tableView.reloadData()
                VC.countryListTxt.isSelected = true
            }

        if let suthramVC = suthramSelected {
            suthramVC.SuthramTxt.text = alphabetic[indexPath.row]
            tableView.reloadData()
            suthramVC.SuthramTxt.isSelected = false
        }

        if let countryCode1 = countryCode {
            countryCode1.countryTxt.text = alphabetic[indexPath.row]
            selectedIndex = indexPath.row
            tableView.reloadData()
        }
        dismissDropDown()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerBtn = UIButton()
        if DeviceType.IS_IPHONE_5 {
            headerBtn.frame = CGRect(x: 260, y: 0, width:50, height: 50)
        }else if DeviceType.IS_IPHONE_6 {
            headerBtn.frame = CGRect(x: 320, y: 0, width:50, height: 50)
        }else if DeviceType.IS_IPHONE_6P {
            headerBtn.frame = CGRect(x: 355, y: 0, width:50, height: 50)
        }
        headerBtn.tag = section
        headerBtn.titleLabel?.font = UIFont(name: fontSize, size: 20)!
        headerBtn.setImage(UIImage(named: "CloseBtn"), for: .normal)
        headerBtn.addTarget(self, action: #selector(DropMenu.dismissDropDown), for: .touchUpInside)
        headerView.addSubview(headerBtn)
        headerView.backgroundColor = .white
        let border = UIView(frame: CGRect(x: 0, y: 44, width: self.dropView.bounds.width, height: 1))
        border.backgroundColor = UIColor.black
        headerView.addSubview(border)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }

    override init() {
        super.init()
        menuItemTable.delegate = self
        menuItemTable.dataSource = self
        menuItemTable.isScrollEnabled = true
        menuItemTable.bounces = false
        menuItemTable.showsVerticalScrollIndicator = false
        menuItemTable.showsHorizontalScrollIndicator = false
        menuItemTable.layer.cornerRadius = 5
        menuItemTable.register(VideoCell.classForCoder(), forCellReuseIdentifier: "cellId")
    }
}
