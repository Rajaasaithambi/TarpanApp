//
//  Dropdown.swift
//  Tarpan
//
//  Created by raja A on 9/7/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import Foundation
import UIKit

class Dropdown: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var menuItemTable: UITableView!
    let dropView = UIView()
    var listOfCountry = [String]()
    var basicDetailsView: BasicDetailsViewController?
    var alphabetic = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        listOfCountry = ["India", "United States of America (USA)", "Virgin Islands (UK)", "Singapore", "China", "Japan", "Ireland","Israel","Italy", "Botswana","Brazil","Brunei","Bulgaria","Burkina Faso","Burundi"]
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alphabetic = listOfCountry.sorted()
        return alphabetic.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = alphabetic[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let countryNames = basicDetailsView {
            countryNames.countryListTxt.text = alphabetic[indexPath.row]
        }
        self.dismiss(animated: true, completion: nil)
    }
}
