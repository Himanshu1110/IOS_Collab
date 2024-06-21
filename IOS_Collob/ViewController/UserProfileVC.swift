//
//  UserProfileVC.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class UserProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categorySongs = ["LIKED","POPULAR","ALBUMS"]
    
    var likedSongArray = [
        ["Song":"Faded" , "Duration":"2:56"],
        ["Song":"Sweet Dreams" , "Duration":"3:56"],
        ["Song":"Man on Moon","Duration":"4:12"],
        ["Song":"Hello world","Duration":"2:21"]
    ]
    // MARK: -  IBOutlets
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    @IBOutlet weak var tblUserProfile: UITableView!
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tblUserProfile.delegate = self
        tblUserProfile.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = true
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        btnFollow.layer.borderWidth = 1
        btnFollow.layer.borderColor = UIColor.white.cgColor
        btnFollow.layer.cornerRadius = 8
        btnFollow.clipsToBounds = true
        
        imgUser.layer.cornerRadius = imgUser.frame.height / 2
        imgUser.clipsToBounds = true
        
        setUserProfile()
    }
    
    override func viewWillLayoutSubviews() {
        tblUserProfile.reloadData()
    }
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        tblUserProfile.reloadData()
//    }
    
    // MARK: IBActions
    @IBAction func onClickFollow(_ sender: Any) {
        
        btnFollow.backgroundColor = #colorLiteral(red: 0.8784, green: 0.8863, blue: 0.3451, alpha: 1)
        btnFollow.tintColor = #colorLiteral(red: 0.1608, green: 0.1216, blue: 0.3176, alpha: 1)
    }
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsUserLoggedIn")
        self.tabBarController?.navigationController?.popViewController(animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
    func setUserProfile(){
        imgUser.image = UIImage(named: "UserImg")
        lblUserName.text = "Alen Walker"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categorySongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tblUserProfile.dequeueReusableCell(withIdentifier: "UserProfileLikedSongTblCell", for: indexPath) as! UserProfileLikedSongTblCell
            cell.CvLikedSong.reloadData()
            cell.lblCategory.text = categorySongs[indexPath.row]
            cell.likedSongArr = self.likedSongArray
            return cell
        }else if indexPath.row == 1{
            
            let cell = tblUserProfile.dequeueReusableCell(withIdentifier: "UserProfilePopularSongTblCell", for: indexPath) as! UserProfilePopularSongTblCell
            cell.lblCategory.text = categorySongs[indexPath.row]
            
            return cell
            
        }else{
            let cell = tblUserProfile.dequeueReusableCell(withIdentifier: "UserProfilePopularSongTblCell", for: indexPath) as! UserProfilePopularSongTblCell
            cell.lblCategory.text = categorySongs[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 400
        }else{
            return 250
        }
    }

}
