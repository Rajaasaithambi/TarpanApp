//
//  VideoCell.swift
//  Tarpan
//
//  Created by raja A on 8/29/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet var songNameLab: UILabel!
    @IBOutlet var songTimeLab: UILabel!
    @IBOutlet var songView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
