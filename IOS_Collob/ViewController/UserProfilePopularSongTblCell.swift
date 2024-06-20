//
//  UserProfilePopularSongTblCell.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class UserProfilePopularSongTblCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var popularSongArr = ["Faded","Sweet Dreams","Man on Moon","Hello world"]
    
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var CvPopularSongs: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CvPopularSongs.delegate = self
        CvPopularSongs.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularSongArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cvCell = CvPopularSongs.dequeueReusableCell(withReuseIdentifier: "PopularSongsCvCell", for: indexPath) as! PopularSongsCvCell
        cvCell.lblSongName.text = popularSongArr[indexPath.row]
        cvCell.lblSongName.textColor = .white
        cvCell.lblSongName.font = UIFont.boldSystemFont(ofSize: 18.0)
        cvCell.imgSong.image = UIImage(named: "\(popularSongArr[indexPath.row])")
        cvCell.imgSong.layer.cornerRadius = 15
        cvCell.imgSong.clipsToBounds = true
        
        return cvCell
    }
    
}
