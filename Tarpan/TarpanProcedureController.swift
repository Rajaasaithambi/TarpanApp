//
//  TarpanProcedureController.swift
//  Tarpan
//
//  Created by raja A on 9/13/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class TarpanProcedureController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var matLab: UILabel!
    @IBOutlet var plateLab: UILabel!
    @IBOutlet var waterLab: UILabel!
    @IBOutlet var sesameLab: UILabel!
    @IBOutlet var pageScroll: UIPageControl!

    var tarpanPR = [String]()
    var tarpanTitle = [String]()
    var startTP = "VideoController"
    var scrollingTimer = Timer()
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tarpanPR = ["Mat", "Copper Plate", "WaterVessel", "Plate_SesameBlack", "Tharpanam_Sesame_Water"]
        tarpanTitle = ["Mat", "CopperPlate", "TharpanamSesameWater", "SesameBlack"]
        collectionview.layer.cornerRadius = 10
        let font = UIFont(name: "BradleyHandITCTT-Bold", size: 20)
        if DeviceType.IS_IPHONE_5 {
            matLab.font = font
            plateLab.font = font
            waterLab.font = font
            sesameLab.font = font
        }
        self.collectionview.isPagingEnabled = true
        pageScroll.hidesForSinglePage = true
        let kAutoScrollDuration: CGFloat = 2.0
        let timer = Timer.scheduledTimer(timeInterval: TimeInterval(kAutoScrollDuration), target: self, selector: #selector(self.nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }

    @IBAction func dismissVc(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tarpanPR.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell
        cell?.TRImage.image = UIImage(named: tarpanPR[indexPath.row])
        cell?.TRImage.layer.cornerRadius = 10
        self.pageScroll.numberOfPages = tarpanPR.count
        return cell!
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageScroll.currentPage = self.currentPage
    }

    func startTimer(theTimer: Timer) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: { 
            self.collectionview.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section:0), at: .centeredHorizontally, animated: true)
        }, completion: nil)
    }

    @IBAction func startTapanaBtn(_ sender: UIButton) {
//        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P {
            let videoVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: startTP) as? VideoController
            videoVC?.isHiddenHomeBtn1 = false
            self.present(videoVC!, animated: true, completion: nil)
        //}
    }

   func nextPage() {
        // 1.back to the middle of sections
        var currentIndexPathReset = self.resetIndexPath()
        // 2.next position
        let pageControll = pageScroll.currentPage
        var nextItem: Int = pageControll
        nextItem = currentIndexPathReset.item + 1
        if nextItem == self.tarpanPR.count {
            nextItem = 0
        }
        let nextIndexPath = IndexPath(item: nextItem, section: 0)
        // 3.scroll to next position
        self.collectionview?.scrollToItem(at: nextIndexPath, at: .right, animated: true)
    }

    func resetIndexPath() -> IndexPath {
        // currentIndexPath
        var currentIndexPath: IndexPath? = self.collectionview?.indexPathsForVisibleItems.last
        // back to the middle of sections
        let currentIndexPathReset = IndexPath(item: (currentIndexPath?.item)!, section: 0)
        self.collectionview?.scrollToItem(at: currentIndexPathReset, at: .right, animated: false)
        return currentIndexPathReset
    }
}
