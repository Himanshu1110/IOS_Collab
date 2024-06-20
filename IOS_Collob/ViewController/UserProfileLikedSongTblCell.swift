//
//  UserProfileLikedSongTblCell.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class UserProfileLikedSongTblCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    var likedSongArr = ["Faded","Sweet Dreams","Man on Moon","Hello world"]

    var likedSongArr = [[String:String]]()
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var CvLikedSong: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CvLikedSong.delegate = self
        CvLikedSong.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedSongArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cvCell = CvLikedSong.dequeueReusableCell(withReuseIdentifier: "LikedSongCvCell", for: indexPath) as! LikedSongCvCell
        
        cvCell.lblSongCount.text = "\(indexPath.row + 1)"
        cvCell.lblSongName.text = likedSongArr[indexPath.row]["Song"]
        cvCell.imgSong.image = UIImage(named: "\(likedSongArr[indexPath.row]["Song"] ?? "")")
        cvCell.lblSongDuration.text = likedSongArr[indexPath.row]["Duration"]
        cvCell.imgLiked.image = UIImage(named: "Liked")
        return cvCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        var w:CGFloat = 0.0
        w = self.CvLikedSong.frame.width

        return CGSize(width: w, height: 90 )
        
        }


}
