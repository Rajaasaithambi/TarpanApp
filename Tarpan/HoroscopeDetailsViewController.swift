//
//  HoroscopeDetailsViewController.swift
//  Tarpan
//
//  Created by raja A on 9/8/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class HoroscopeDetailsViewController: UIViewController {

    @IBOutlet var dateLab: UILabel!
    @IBOutlet var AutherLab: UILabel!
    @IBOutlet var discriptionLab: UILabel!
    @IBOutlet var horoscopeLogoImageView: UIImageView!
    @IBOutlet var horoscopeTitleLab: UILabel!
    //var activity = UIActivityIndicatorView()
    var dateStr = String()
    var AutherStr = String()
    var discriptionStr = String()
    var horoscopeImage = UIImage()
    var horoscopeTitleStr = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        dateLab.text = dateStr
        AutherLab.text = AutherStr
        discriptionLab.text = discriptionStr
        horoscopeLogoImageView.image = horoscopeImage
    }

    @IBAction func dismissHorosDetails(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func dismiss() {
        dismiss(animated: false, completion: nil)
    }
}
