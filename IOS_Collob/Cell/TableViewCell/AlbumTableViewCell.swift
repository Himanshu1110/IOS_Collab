//
//  NewReleaseTableViewCell.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var NewReleaseCollectionView: UICollectionView!
    
    var albums = [""]
    var albumNames = [""]
    var albumSingers = [""]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NewReleaseCollectionView.delegate = self
        NewReleaseCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Providing the Data Source
        let cell = NewReleaseCollectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        
        
        cell.imageAlbum.image = UIImage(named: albums[indexPath.item])
        cell.imageAlbum.applyCornerRadius(radius: 20)
        cell.lbAlbumName.text = albumNames[indexPath.item]
        cell.lbSingerName.text = albumSingers[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 153)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}
