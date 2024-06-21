//
//  NewReleaseTableViewCell.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

protocol MovetoScreen{
    func MoveToDetailScreen(ImageName : String)
    func MovetoSingerProfileScreen(index: Int)
}

class AlbumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Ib Outlet Collection View
    @IBOutlet weak var AlbumCollectionView: UICollectionView!
    
    // MARK: - Static Data
    var albums = [""]
    var albumNames = [""]
    var albumSingers = [""]
    var isSingers = false
    
    
    var delegateSinger: MovetoScreen!
    var delegate : MovetoScreen!
    
    // MARK: - Table View Cell Delegates
    override func awakeFromNib() {
        super.awakeFromNib()
        
        AlbumCollectionView.delegate = self
        AlbumCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    // MARK: - Collection Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Providing the Data Source
        let cell = AlbumCollectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        
        
        cell.imageAlbum.image = UIImage(named: albums[indexPath.item])
        cell.lbSingerName.text = albumSingers[indexPath.item]
        
        if isSingers {
            cell.imageAlbum.makeCircle()
            cell.lbAlbumName.isHidden = true
            cell.lbSingerName.font = .systemFont(ofSize: 15)
            cell.lbSingerName.translatesAutoresizingMaskIntoConstraints = false
            cell.lbSingerName.textAlignment = .center
            cell.lbSingerName.topAnchor.constraint(equalTo: cell.imageAlbum.bottomAnchor, constant: 10).isActive = true
        }else{
            cell.imageAlbum.applyCornerRadius(radius: 20)
            cell.lbAlbumName.text = albumNames[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 134, height: 153)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSingers {
            delegateSinger.MovetoSingerProfileScreen(index: indexPath.item)
        }
        delegate?.MoveToDetailScreen(ImageName: albums[indexPath.item] )

    }

}
