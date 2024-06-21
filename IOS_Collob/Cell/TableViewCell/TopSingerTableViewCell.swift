//
//  TopSingerTableViewCell.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class TopSingerTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var TopSingerCollectionView: UICollectionView!
    
    var singers = [""]
    var singerNames = [""]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        TopSingerCollectionView.delegate = self
        TopSingerCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        singers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = TopSingerCollectionView.dequeueReusableCell(withReuseIdentifier: "TopSingerCollectionViewCell", for: indexPath) as! TopSingerCollectionViewCell
        cell.imageSinger.image = UIImage(named: singers[indexPath.item])
        cell.imageSinger.makeCircle()
        cell.lbSingerName.text = singerNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 138)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

}
