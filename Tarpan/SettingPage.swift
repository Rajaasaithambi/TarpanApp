//
//  SettingPage.swift
//  Tarpan
//
//  Created by raja A on 9/13/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class SettingPage: UIViewController {

    @IBOutlet var prefrenceBtn: UIButton!
    @IBOutlet var aboutBtn: UIButton!
    @IBOutlet var aboutview: UIView!
    var mobile = String()
    var uuid = String()

    let blackColor = UIColor(colorWithHexValue: 0x000000)
    let redColour = UIColor(colorWithHexValue: 0xFF4C00)
    let titleTintColor = UIColor(colorWithHexValue: 0xffffff)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        aboutview.isHidden = true


    }

    @IBAction func SeetingPg(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 1 {
            self.radioBtn()
            aboutBtn.titleLabel?.textColor = blackColor
            aboutBtn.backgroundColor = titleTintColor
        }else if sender.tag == 2 {
            self.radioBtn()
            prefrenceBtn.titleLabel?.textColor = blackColor
            prefrenceBtn.backgroundColor = titleTintColor
        }
    }

    @IBAction func dismissSettingPG(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func radioBtn() {
        if prefrenceBtn.isSelected {
            prefrenceBtn.backgroundColor = redColour
            prefrenceBtn.setTitleColor(titleTintColor, for: .normal)
            prefrenceBtn.isSelected = false
            aboutview.isHidden = true
        }else if aboutBtn.isSelected {
            aboutBtn.backgroundColor = redColour
            aboutBtn.setTitleColor(titleTintColor, for: .normal)
            aboutBtn.isSelected = false
            aboutview.isHidden = false
        }
    }
}
