//
//  CollectionView.swift
//  Tarpan
//
//  Created by raja A on 8/21/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var titleArr = [String]()
    var imageArr = [String]()
    var subTitleArr = [String]()
    var imageSize = 50
    var mobile = String()
    var uuid = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.createBarBtn(imageName: "Setting.png")
        titleArr = ["START TARPAN", "GUIDE       TOUR", "HOROSCOPE", "VIDEOS"]
        subTitleArr = ["20 MINS", "2 MINS", "5 ITEMS", "5 VIDEOS"]
        imageArr = ["startTarpan", "guideTour", "horoscopeImage", "videoImage"]
        collectionView.reloadData()

       if DeviceType.IS_IPHONE_5 {
            screenSize = UIScreen.main.bounds
            screenWidth = screenSize.width
            screenHeight = screenSize.height
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20)
            layout.itemSize = CGSize(width: (screenWidth/3)*1.25, height: screenWidth/2)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            collectionView!.collectionViewLayout = layout
       }else if DeviceType.IS_IPHONE_6P {
            let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flow.sectionInset = UIEdgeInsets(top: 50, left: 60, bottom: 0, right: 60)
            flow.minimumLineSpacing = 10
       }else if DeviceType.IS_IPAD {
        titleArr = ["START        TARPAN", "GUIDE               TOUR", "HOROSCOPE", "VIDEOS"]
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 80, left: 250, bottom: 0, right: 250)
        layout.itemSize = CGSize(width: (screenWidth/4), height: screenWidth/4)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
        }
    }

    @IBAction func goToSettingPage(_ sender: UIBarButtonItem) {
       self.performSegue(withIdentifier: "settingVC", sender: self)
    }


    func createBarBtn(imageName: String) {
        let icon = UIImage(named: imageName)
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        iconButton.addTarget(self, action: #selector(CollectionView.settingBtnAction), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: iconButton)
        self.navigationItem.rightBarButtonItem = item1
    }

    func settingBtnAction() {

        let VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingPage") as? SettingPage
        self.present(VC!, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell
        if DeviceType.IS_IPAD {
            cell?.heightImageConstraint.constant = 60
            cell?.widthImageConstraint.constant = 60
            cell?.topImageContraint.constant = 40
            cell?.titleLab.font = UIFont(name: "BradleyHandITCTT-Bold", size: 27)
            cell?.subTitleLab.font = UIFont(name: "BradleyHandITCTT-Bold", size: 15)
        }
        cell?.titleLab.text = titleArr[indexPath.row]
        cell?.subTitleLab.text = subTitleArr[indexPath.row]
        cell?.imageIcon.image = UIImage(named: imageArr[indexPath.row])
         if indexPath.row == 2 {
            if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6P {
                cell?.imageIcon.isHidden = true
                let horoscopeImage = UIImageView(frame: CGRect(x: 50, y: 30, width: imageSize, height: imageSize))
                let horoscopeIconImge: UIImage = UIImage(named: "horoscopeImage")!
                let passwordImageview:UIImageView=UIImageView(frame: CGRect(x: 105, y: 10, width: 20, height: 25))
                let image:UIImage = UIImage(named:"passwordImageview")!
                passwordImageview.image = image
                horoscopeImage.image = horoscopeIconImge
                cell?.contentView.addSubview(passwordImageview)
                cell?.contentView.addSubview(horoscopeImage)
            }else if DeviceType.IS_IPAD {
                cell?.imageIcon.isHidden = true
                let horoscopeImage = UIImageView(frame: CGRect(x: 110, y: 60, width: imageSize, height: imageSize))
                let horoscopeIconImge: UIImage = UIImage(named: "horoscopeImage")!
                let passwordImageview:UIImageView=UIImageView(frame: CGRect(x: 205, y: 20, width: 30, height: 40))
                let image:UIImage = UIImage(named:"passwordImageview")!
                passwordImageview.image = image
                horoscopeImage.image = horoscopeIconImge
                cell?.contentView.addSubview(passwordImageview)
                cell?.contentView.addSubview(horoscopeImage)
            }
         }else if indexPath.row == 3 {
            if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6P {
                cell?.imageIcon.isHidden = true
                let videoImage = UIImageView(frame: CGRect(x: 55, y: 30, width: 40, height: 25))
                let videoIconImge: UIImage = UIImage(named: "videoImage")!
                videoImage.image = videoIconImge
                cell?.contentView.addSubview(videoImage)
            } else if DeviceType.IS_IPAD {
                cell?.imageIcon.isHidden = true
                let videoImage = UIImageView(frame: CGRect(x: 110, y: 60, width: imageSize, height: imageSize))
                let videoIconImge: UIImage = UIImage(named: "videoImage")!
                videoImage.image = videoIconImge
                cell?.contentView.addSubview(videoImage)
            }
        }
        return cell!
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "BasicVC", sender: self) 
        case 1:
            print("case 1")
        case 2:
            let horoscopeVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HoroscopeViewController") as? HoroscopeViewController
            self.present(horoscopeVC!, animated: true, completion: nil)
        default:
            let identifier = "VideoController"
            let videoVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? VideoController
            videoVC?.isHiddenHomeBtn1 = true
            self.present(videoVC!, animated: true, completion: nil)
        }
    }
}

