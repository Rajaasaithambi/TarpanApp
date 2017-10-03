//
//  HoroscopeViewController.swift
//  Tarpan
//
//  Created by raja A on 9/8/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class HoroscopeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionview: UICollectionView!
    var horoscopeArray = [String]()
    var horoscopeTitleArr = [String]()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        if DeviceType.IS_IPHONE_5 {
            screenSize = UIScreen.main.bounds
            screenWidth = screenSize.width
            screenHeight = screenSize.height
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 0, right: 30)
            layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/4)
            layout.minimumLineSpacing = 5
            collectionview!.collectionViewLayout = layout
        }else if DeviceType.IS_IPHONE_6P {
            screenSize = UIScreen.main.bounds
            screenWidth = screenSize.width
            screenHeight = screenSize.height
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 0, right: 30)
            layout.itemSize = CGSize(width: ((screenWidth/4)*1.05), height: screenWidth/4)
            layout.minimumLineSpacing = 5
            collectionview!.collectionViewLayout = layout
        }else if DeviceType.IS_IPAD {
            screenSize = UIScreen.main.bounds
            screenWidth = screenSize.width
            screenHeight = screenSize.height
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 50, left: 250, bottom: 0, right: 250)
            layout.itemSize = CGSize(width: ((screenWidth/4)*0.65), height: (screenWidth/4)*0.65)
            layout.minimumLineSpacing = 10
            collectionview!.collectionViewLayout = layout
        }

        title = "Daily Horoscope"
        horoscopeArray = ["aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces"]
        horoscopeTitleArr = ["ARIES", "TAURNS", "GENIMI", "CANCER", "LEO", "VIRGO", "LIBRA", "SCORPIO", "SAGITTARIUS", "CAPRICORN", "AQUARIUS", "PISCES"]
        let backgroundImage = UIImage(named: "photo")
        let imageView = UIImageView(image: backgroundImage)
        self.collectionview.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
        collectionview.backgroundColor = .lightGray
    }

    @IBAction func dismissHoroscopr(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horoscopeArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell
        cell?.nameLAb.text = horoscopeTitleArr[indexPath.row]
        cell?.loginSliderImage.image = UIImage(named: horoscopeArray[indexPath.row])
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }

    func getData(url: String, image: String, title: String)  {
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
        self.navigationController?.view.showLoadingView()
        let dataTask = session.dataTask(with: URL.init(string: url)!) { (data, response, error) in

            if error != nil {
                //
                self.dismiss()
            }
            else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                    if let horoscope = jsonResult["horoscope"] as? String, let date = jsonResult["date"] as? String {
                        if Reachability.isConnectedToNetwork() == true {
                            DispatchQueue.main.async {
                                self.horoscopeDetailPage(segeuId: "HoroscopeDetailsViewController", description: horoscope, date: date, auther: "by Pankaj khanna", image: image, title: title)
                                self.navigationController?.view.hideLoadingView()
                            }
                        }else {
                            let alert = UIAlertController(title: "Error", message: "Internet Connection not Available!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Okey", style: .default)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } catch  {
                    print ("Error")
                    self.dismiss()
                }
            }
        }
        dataTask.resume()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.getData(url: "http://sandipbgt.com/theastrologer/api/horoscope/\(self.horoscopeArray[indexPath.row])/today/", image: "\(self.horoscopeArray[indexPath.row])", title: "\(self.horoscopeTitleArr[indexPath.row])")
    }

    func horoscopeDetailPage(segeuId: String,description: String, date: String, auther: String,image: String, title: String) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: segeuId) as? HoroscopeDetailsViewController
        vc?.discriptionStr = description
        vc?.dateStr = date
        vc?.AutherStr = auther
        vc?.horoscopeImage = UIImage(named: image)!
        vc?.title = title
        self.present(vc!, animated: true, completion: nil)
    }


    func activityIndicator() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    func dismiss() {
        dismiss(animated: false, completion: nil)
    }
}
