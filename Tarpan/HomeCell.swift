//
//  HomeCell.swift
//  Tarpan
//
//  Created by raja A on 8/21/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var titleLab: UILabel!
    @IBOutlet var subTitleLab: UILabel!
    @IBOutlet var heightImageConstraint: NSLayoutConstraint!
    @IBOutlet var widthImageConstraint: NSLayoutConstraint!
    @IBOutlet var topImageContraint: NSLayoutConstraint!
   


    // Horoscope 

    @IBOutlet var loginSliderImage: UIImageView!
    @IBOutlet var nameLAb: UILabel!

    // Suthram

    @IBOutlet var suthramTitle: UILabel! = nil
    @IBOutlet var backView: UIView!


    // Tarpan Ready to do

    @IBOutlet var TRImage: UIImageView!
    @IBOutlet var TRTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
