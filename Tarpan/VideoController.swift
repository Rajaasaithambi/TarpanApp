//
//  VideoController.swift
//  Tarpan
//
//  Created by raja A on 8/28/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
import AVFoundation

class VideoController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var speedLab: UILabel!
    @IBOutlet var play_PauseBtn: UIButton!
    @IBOutlet var currentTimeVideo: UILabel!
    @IBOutlet var Slider: UISlider!
    @IBOutlet var customView: viewDesignable!
    @IBOutlet var tableview: UITableView!
    @IBOutlet var sliderOutLet: UISlider!
    @IBOutlet var doneBtn: UIBarButtonItem!
    var isPlay = true
    var player: AVPlayer?
    let seekDuration: Float64 = 2
    var identifier = String()
    var item = [AVPlayerItem]()
    var commomQueuePlayer = AVQueuePlayer()
    let fontSize = "BradleyHandITCTT-Bold"
    var videoList = [String]()
    var videoLength = [String]()
    var constant = String()
    var isHiddenHomeBtn1: Bool!
    var barBtn = UIButton()
    var segueID = "VideoController"

    override func viewDidLoad() {
        super.viewDidLoad()
        if barBtn.isHidden == isHiddenHomeBtn1 {
            self.barButton()
            loadVideo(videoName: "Tarpanam", Type: ".mp4")
            videoList = ["F", "F1", "newVideo"]
            videoLength = ["04:55","02:44", "00:06"]

        }else {
            loadVideo(videoName: "F1", Type: ".mp4")
            videoList = ["1", "2"]
            videoLength = ["02:32","04:34", "00:06"]
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playAndPuase))
        customView.addGestureRecognizer(tapGesture)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.pause()
        player = nil
    }

    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? CollectionView
        self.present(loginVC!, animated: true, completion: nil)
    }
    func barButton() {

        barBtn = UIButton(type: .roundedRect)
        barBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        barBtn.setTitle("Done", for: .normal)
        barBtn.setTitleColor(UIColor(colorWithHexValue: 0xFF4C00), for: .normal)
        barBtn.titleLabel?.font = UIFont(name: "BradleyHandITCTT-Bold", size: 20.0)
        barBtn.addTarget(self, action: #selector(VideoController.btnAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: barBtn)
        self.navigationItem.rightBarButtonItem = barButton
    }

    func btnAction() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }


    func timeObserve() {
        let currentPlayerItem = player?.currentItem
        let duration = currentPlayerItem?.asset.duration
        print(duration!)
        let currentTime = Float((self.player?.currentTime().value)!)
        if currentTime >= 5 {
             print("NotificationCenter")
        }else if currentTime <= 5 {
        
        }
    }

    internal func selectVideoWithLoop(url : URL)
    {
        let asset = AVAsset(url: url)
        commomQueuePlayer.pause()
        let playerItem1 = AVPlayerItem(asset: asset)
        let playerItem2 = AVPlayerItem(asset: asset)
        commomQueuePlayer.removeAllItems()
        commomQueuePlayer.replaceCurrentItem(with: playerItem1)
        commomQueuePlayer.insert(playerItem2, after: playerItem1)
        commomQueuePlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.advance
        commomQueuePlayer.play()

        let selector = #selector(VideoController.playerItemDidReachEnd(notification:))
        let name = NSNotification.Name.AVPlayerItemDidPlayToEndTime
        // removing old observer and adding it again for sequential calls.
        // Might not be necessary, but I like to unregister old notifications.
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    func playerItemDidReachEnd(notification: Notification)
    {
        let item = commomQueuePlayer.currentItem!
        commomQueuePlayer.remove(item)
        item.seek(to: kCMTimeZero)
        commomQueuePlayer.insert(item, after: nil)
    }

    func playToNextVideo() {
        let firstVideo: String = "F"
        let secondVideo: String = "F1"
        let thirdVideo: String = "newVideo"
        let firstItem = AVPlayerItem(url: URL(fileURLWithPath: firstVideo))
        let scItem = AVPlayerItem(url: URL(fileURLWithPath: secondVideo))
        let thirItem = AVPlayerItem(url: URL(fileURLWithPath: thirdVideo))
        item = [firstItem, scItem, thirItem]
        commomQueuePlayer = AVQueuePlayer(items: item)
        //player = AVPlayer(url: URL(fileURLWithPath: "\(item)"))
        let playerLayer = AVPlayerLayer(player: commomQueuePlayer)
        playerLayer.frame = customView.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResize
        customView.layer.addSublayer(playerLayer)
        playerLayer.player?.allowsExternalPlayback = true
        self.commomQueuePlayer.play()

    }

    func playAndPuase() {
        isPlay = !isPlay
        if isPlay == false {
            play_PauseBtn.setImage(UIImage(named: "Play"), for: .normal)
            player?.pause()
        } else {
            play_PauseBtn.setImage(UIImage(named: "Pause"), for: .normal)
            player?.play()
        }
    }

    func loadVideo(videoName: String, Type: String) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: Type) else {
            debugPrint("Tarpanam.mp4 not found")
            return
        }

        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = customView.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResize
        playerLayer.cornerRadius = 10
        customView.layer.addSublayer(playerLayer)
        isPlay = true
        if isPlay == false {
            play_PauseBtn.setImage(UIImage(named: "Play"), for: .normal)
            player?.pause()
        } else {
            play_PauseBtn.setImage(UIImage(named: "Pause"), for: .normal)
            player?.play()
        }
        Slider.addTarget(self, action: #selector(updateSlider), for: .valueChanged)
        self.Slider.setThumbImage(UIImage(named: "Thum"), for: UIControlState.normal)
        self.leftSideTimeLab()
        tableview.layer.cornerRadius = 10
    }

    func updateSlider() {
        if let duration = player?.currentItem?.duration {
            let totalDuration = CMTimeGetSeconds(duration)
            let value = Float64(Slider.value) * totalDuration
            let seek = CMTime(value: CMTimeValue(value), timescale: 1)
            player?.seek(to: seek, completionHandler: { (complseek) in
            })
        }
    }

    func leftSideTimeLab() {
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progress) in
            let second = CMTimeGetSeconds(progress)
            let intOfSeconds = Int(second)
            let time = 60
            let secondStr = intOfSeconds % time
            let secondString = String(format: "%02d",secondStr)
            let minus = String(format: "%02d", Int(second / 60))
            self.currentTimeVideo.text = "\(minus):\(secondString)"
            if let duration = self.player?.currentItem?.duration {
                let durationSecond = CMTimeGetSeconds(duration)
                self.Slider.value = Float(second / durationSecond)
            }
        })
    }

    @IBAction func play_pause(_ sender: UIButton) {
        self.playAndPuase()
    }

    @IBAction func specker(_ sender: UIButton) {
//        sliderOutLet.isHidden = false
//        sliderOutLet.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
//        sliderOutLet.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
    }

    @IBAction func plus_minus(_ sender: UIButton) {
        if sender.tag == 1 {
            player?.pause()
            let playerCurrentTime = CMTimeGetSeconds((player?.currentTime())!)
            var newTime = playerCurrentTime - seekDuration
            if newTime < 0 {
                newTime = 0
            }
            let time2: CMTime = CMTimeMake(Int64(newTime * 1000 as Float64), 1000)
            player?.seek(to: time2)
            player?.play()
        }else if sender.tag == 2 {
            guard let duration  = player?.currentItem?.duration else {
                return
            }
            let currentTime:Double = player!.currentItem!.currentTime().seconds
            let newTime = currentTime + seekDuration
            if newTime < (CMTimeGetSeconds(duration) - seekDuration) {
                let time2: CMTime = CMTimeMake(Int64(newTime * 1000 as Float64), 1000)
                player?.seek(to: time2)
                player?.play()
            } else {
                let duration : CMTime = player!.currentItem!.asset.duration
                player?.seek(to: duration)
                player?.play()
            }
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VideoCell
        cell?.songNameLab.text = videoList[indexPath.row]
        cell?.songTimeLab.text = videoLength[indexPath.row]
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.player?.seek(to: kCMTimeZero)
                self.player?.pause()
                self.player = nil
                self.loadVideo(videoName: self.videoList[0], Type: ".mp4")
                if indexPath.row == 0 {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil, using: { (Noti) in
                        DispatchQueue.main.async {
                            self.player?.seek(to: kCMTimeZero)
                            self.player?.pause()
                            self.player = nil
                            self.loadVideo(videoName: self.videoList[1], Type: ".mp4")
                        }
                    })
                }else if indexPath.row == 1 {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil, using: { (Noti) in
                        DispatchQueue.main.async {
                            self.player?.seek(to: kCMTimeZero)
                            self.player?.pause()
                            self.player = nil
                            self.loadVideo(videoName: self.videoList[2], Type: ".mp4")
                        }
                    })
                }
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player?.pause()
        player = nil
        loadVideo(videoName: (videoList[indexPath.row]), Type: ".mp4")
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{

        switch section
        {
        case 0:
            return "Mantra 1"
        case 1:
            return "Mantra 2"
        default:
            return "Mantra 3"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 60, y: 20, width:tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: fontSize, size: 20)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(self.tableview, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        let headerCountLabel = UILabel(frame: CGRect(x: 15, y: 20, width:tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerCountLabel.font = UIFont(name: fontSize, size: 20)
        headerCountLabel.textColor = UIColor.black
        headerCountLabel.text = self.tableView(self.tableview, titleForHeaderInSection: section)
        headerCountLabel.sizeToFit()
        if section == 0 {
            headerCountLabel.text = "01."
        }else if section == 1{
            headerCountLabel.text = "02."
        }else if section == 2 {
             headerCountLabel.text = "03."
        }
        headerCountLabel.textColor = UIColor(colorWithHexValue: 0xFF4C00)
        headerView.addSubview(headerCountLabel)
        return headerView
    }
}
