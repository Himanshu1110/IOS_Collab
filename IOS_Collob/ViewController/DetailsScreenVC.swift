//
//  DetailsScreenVC.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit

class DetailsScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayButton {
    
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
    
    //MARK: Application Delegate Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMusicDetails.delegate = self
        tblMusicDetails.dataSource = self
        tblMusicDetails.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        
        self.navigationController?.isNavigationBarHidden = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tblMusicDetails.dequeueReusableCell(withIdentifier: "MusicDetailTableViewCell", for: indexPath) as! MusicDetailTableViewCell
            cell.imgMusicCover.image = UIImage(named: imageCover)
            return cell
        }
        else{
            let cell = tblMusicDetails.dequeueReusableCell(withIdentifier: "SongListTableViewCell", for: indexPath) as! SongListTableViewCell
            cell.btnPlay.tag = indexPath.row - 1
            cell.lblSongName.text = MusicArr[indexPath.row - 1]["MusicName"]
            cell.delegate = self
            cell.imgSong.image = UIImage(named: MusicArr[indexPath.row - 1]["MusicName"] ?? "")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isPlayButtonClicked = false
        navigateToMusicPlayer(index: indexPath.row - 1)
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
    
    //MARK: Custom Deletgate Method
    
    func btnClicked(sender: UIButton) {
        isPlayButtonClicked = true
        navigateToMusicPlayer(index: (sender as AnyObject).tag)
    }
}
