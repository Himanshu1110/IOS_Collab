//
//  SongListTableViewCell.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit

class SongListTableViewCell: UITableViewCell {
        
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var imgSong: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgSong.layer.cornerRadius = 15
        imgSong.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func OnClickBtnPlay(_ sender: Any) {
        
        print((sender as AnyObject).tag ?? 0)
        
        NotificationCenter.default.post(name: Notification.Name("btnCLicked"), object: nil, userInfo: ["btnTag": (sender as AnyObject).tag ?? 0])
        
    }
    
}
