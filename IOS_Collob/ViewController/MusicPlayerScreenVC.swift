//
//  ViewController.swift
//  Music Player
//
//  Created by webcodegenie on 13/06/24.
//

import UIKit
import AVFoundation


class MusicPlayerScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var player : AVPlayer?
    var playerItem : AVPlayerItem?
    var isSongSelected = false
    @IBOutlet weak var SldMusicSlider: UISlider!
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var lblMusicName: UILabel!
    
    
    @IBOutlet weak var VwMusicListMainView: UIView!
    @IBOutlet weak var TvMusicListtableView: UITableView!
    
    @IBOutlet weak var btnPlayButton: UIButton!
    
    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var SongListViewHeightConstraint: NSLayoutConstraint!
    
    var SelectedMusicIndex = 0
    var MusicArr = [
        ["MusicName":"Pink Panther 60","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/PinkPanther60.wav"],
        ["MusicName":"Star Wars 60","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/StarWars60.wav"],
        ["MusicName":"Kukushka","MusicURl":"https://s3.amazonaws.com/kargopolov/kukushka.mp3"],
        ["MusicName":"Voice Test","MusicURl":"https://www.kozco.com/tech/WAV-MP3.wav"],
        ["MusicName":"Organ Finale","MusicURl":"https://www.kozco.com/tech/organfinale.mp3"],
        ["MusicName":"Baby Elephant Walk 60","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav"],
        ["MusicName":"Cantina Band 3","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand3.wav"],
        ["MusicName":"Cantina Band 60","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav"],
        ["MusicName":"Fan Fare","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/Fanfare60.wav"],
        ["MusicName":"gettys burg 10","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/gettysburg10.wav"],
        ["MusicName":"Imperial March 60","MusicURl":"https://www2.cs.uic.edu/~i101/SoundFiles/ImperialMarch60.wav"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TvMusicListtableView.delegate = self
        TvMusicListtableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        SetAVPlayerForAudio(SelectedMusicIndex: SelectedMusicIndex)
        SetUI()
//        SldMusicSlider.setThumbImage(UIImage(named: "thumb"), for: .normal)
//
        if isSongSelected {
            player!.play()
            btnPlayButton.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
            isSongSelected = false
        }
        setUpMenuButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player!.pause()
        btnPlayButton.setImage(UIImage(named: "play"), for: UIControl.State.normal)
    }
    // MARK: - All IBActions
    
    @IBAction func OnClickPlayAndPause(_ sender: Any) {
        
        print("Play Button Pressed")
        
        if player?.rate == 0
        {
            player!.play()
            btnPlayButton.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        } else {
            player!.pause()
            btnPlayButton.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func OnClickNextSong(_ sender: Any) {
        if SelectedMusicIndex != MusicArr.count-1 {
            SelectedMusicIndex = SelectedMusicIndex + 1
            SetAVPlayerForAudio(SelectedMusicIndex: SelectedMusicIndex)
            player?.play()
            btnPlayButton.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        }
        
    }
    
    @IBAction func OnClickPreviousSong(_ sender: Any) {
        if SelectedMusicIndex != 0 {
            SelectedMusicIndex = SelectedMusicIndex - 1
            SetAVPlayerForAudio(SelectedMusicIndex: SelectedMusicIndex)
            player?.play()
            btnPlayButton.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func SliderAction(_ sender: Any) {
        
        let seconds : Int64 = Int64(SldMusicSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    
    @IBAction func OnClickBacktoMainScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - All Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MusicListTableCell") as! MusicListTableCell
        
        Cell.lblMusicName.text = MusicArr[indexPath.row]["MusicName"]
        Cell.imgMusicImage.image = UIImage(named: MusicArr[indexPath.row]["MusicName"] ?? "")
        Cell.imgMusicImage.layer.cornerRadius = 10
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != SelectedMusicIndex{
            SelectedMusicIndex = indexPath.row
            SetAVPlayerForAudio(SelectedMusicIndex: SelectedMusicIndex)
        }
        player?.play()
        btnPlayButton.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
     
        
    }
    
    
    
    // MARK: - All Objc Functions
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        btnPlayButton.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        SetAVPlayerForAudio(SelectedMusicIndex: SelectedMusicIndex)
    }
    @objc func btnBackClicked() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    // MARK: - All Defined Functions
    
    func SetAVPlayerForAudio(SelectedMusicIndex : Int){
        
        let MusicUrl = MusicArr[SelectedMusicIndex]["MusicURl"] ?? ""
        lblMusicName.text = MusicArr[SelectedMusicIndex]["MusicName"] ?? ""
        
        let url = URL(string: MusicUrl)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        btnPlayButton.setImage(UIImage(named: "play"), for: .normal)
        
        // This will set Max Time Label text to Overall Duration
        let OverAllDuration : CMTime = playerItem.asset.duration
        let TotalSeconds : Float64 = CMTimeGetSeconds(OverAllDuration)
        lblMaxTime.text = self.stringFromTimeInterval(interval: TotalSeconds)
        
        // This will set Current Time Label text to Overall Duration
        let CurrentDuration : CMTime = playerItem.currentTime()
        let CurrentSeconds : Float64 = CMTimeGetSeconds(CurrentDuration)
        lblCurrentTime.text = self.stringFromTimeInterval(interval: CurrentSeconds)
        
        imgImageView.image = UIImage(named: MusicArr[SelectedMusicIndex]["MusicName"] ?? "")
        
        // This Will Set Slider Value
        SldMusicSlider.maximumValue = Float(TotalSeconds)
        SldMusicSlider.isContinuous = true
        SldMusicSlider.value = 0
        //        self.Loader.hide()
        
        //Notification Obeserver trigger when music end playing
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        // It will check current music time and will update slider and Current time Label value
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                
                self.SldMusicSlider.value = Float ( time );
                
                self.lblCurrentTime.text = self.stringFromTimeInterval(interval: time)
                //                self.Loader.hide()
            }
            
            
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                //                self.Loader.show(on: self.view)
                
            } else {
                //stop the activity indicator
                print("Buffering completed")
                //                self.Loader.hide()
            }
            
        }
        
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func SetBackgroundBlur(view : UIView ){
        // blur Effect Code
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
    func SetUI(){
        
        SetBackgroundBlur(view: VwMusicListMainView)
        
        imgImageView.layer.cornerRadius = 10
        
        VwMusicListMainView.layer.cornerRadius = 10
        VwMusicListMainView.layer.masksToBounds = true
        
    }
    func setUpMenuButton(){
        
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = .white
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)

        navigationItem.leftBarButtonItem = barButton
    }
}
