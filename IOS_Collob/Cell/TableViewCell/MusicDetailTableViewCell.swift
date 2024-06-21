//
//  MusicDetailTableViewCell.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit

class MusicDetailTableViewCell: UITableViewCell {
    var flagLike = false
    @IBOutlet weak var MaskedView: UIView!
    @IBOutlet weak var imgMusicCover: UIImageView!
        @IBOutlet weak var btnMenu: UIButton!
        @IBOutlet weak var btnDownload: UIButton!
        @IBOutlet weak var btnLike: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        MaskedView.layer.cornerRadius = 23
//        MaskedView.layer.masksToBounds = true
        MaskedView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
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
            btnDownload.tintColor = .black
    
        }

}
