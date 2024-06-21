//
//  DetailsScreenVC.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit

class DetailsScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayButton {
    let barButton = UIBarButtonItem()
    @IBOutlet weak var lblLeadingConstraint: NSLayoutConstraint!
    var isPlayButtonClicked = false
    var imageCover = "Cover"
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
    @IBOutlet weak var tblMusicDetails: UITableView!
    var flagLike = false
    @IBOutlet weak var MaskedView: UIView!
    @IBOutlet weak var imgMusicCover: UIImageView!
        @IBOutlet weak var btnMenu: UIButton!
        @IBOutlet weak var btnDownload: UIButton!
        @IBOutlet weak var btnLike: UIButton!
    
    //MARK: Application Delegate Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMusicDetails.delegate = self
        tblMusicDetails.dataSource = self
        tblMusicDetails.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    override func viewWillAppear(_ animated: Bool) {
        imgMusicCover.image = UIImage(named: imageCover)
        MaskedView.layer.cornerRadius = 23
        MaskedView.layer.masksToBounds = true
        MaskedView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        tblMusicDetails.showsVerticalScrollIndicator = false
        self.navigationController?.isNavigationBarHidden = false
        setUpMenuButton(isScroll: true)
        checkOrientation()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(tblMusicDetails.contentOffset,tblMusicDetails.contentSize)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        checkOrientation()
    }
    override func viewDidDisappear(_ animated: Bool) {
        if let indexPath = tblMusicDetails.indexPathForSelectedRow {
            tblMusicDetails.deselectRow(at: indexPath, animated: true)
        }
    }

    //MARK: IBAction Methods
    
    @IBAction func onCLickMenu(_ sender: Any) {
    }
    @IBAction func onClickBtnLike(_ sender: Any) {
        flagLike.toggle()
        if flagLike {
            btnLike.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }
        else{
            btnLike.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
    }
    @IBAction func onClickDownload(_ sender: Any) {
        btnDownload.tintColor = .blue

    }
 
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblMusicDetails.dequeueReusableCell(withIdentifier: "SongListTableViewCell", for: indexPath) as! SongListTableViewCell
            cell.btnPlay.tag = indexPath.row
            cell.lblSongName.text = MusicArr[indexPath.row]["MusicName"]
            cell.delegate = self
            cell.imgSong.image = UIImage(named: MusicArr[indexPath.row]["MusicName"] ?? "")
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isPlayButtonClicked = false
        navigateToMusicPlayer(index: indexPath.row)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y) > 1 {
            self.navigationItem.title = "Music Details"
            setUpMenuButton(isScroll: false)
        }
        else{
            self.navigationItem.title = ""
            setUpMenuButton(isScroll: true)
        }
    }
    
    //MARK: User Defined Method
    
    func navigateToMusicPlayer(index : Int){
        let vc = UIStoryboard(name: "MusicPlayeScreen", bundle: nil).instantiateViewController(withIdentifier: "MusicPlayerScreenVC") as! MusicPlayerScreenVC
        print(vc)
        vc.SelectedMusicIndex = index
        if isPlayButtonClicked {
            vc.isSongSelected = true
        }
        else{
            vc.isSongSelected = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpMenuButton(isScroll : Bool){
        
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = isScroll ? .white : .detailsDarkMode
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)

        navigationItem.leftBarButtonItem = barButton
       
    }
    
    func checkOrientation(){
        switch UIDevice.current.orientation {
            
        case .portrait, .portraitUpsideDown:
            lblLeadingConstraint.constant = 20
        case .landscapeLeft,.landscapeRight:
            lblLeadingConstraint.constant = 83
        @unknown default:
            lblLeadingConstraint.constant = 25
        }
    }
    
    //MARK: OBJC Function
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                self.navigationController?.popViewController(animated: true)
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    @objc func btnBackClicked() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Custom Deletgate Method
    
     func btnClicked(sender: UIButton) {
        isPlayButtonClicked = true
        navigateToMusicPlayer(index: (sender as AnyObject).tag)
    }
}
