//
//  MusicListTableCell.swift
//  Music Player
//
//  Created by webcodegenie on 13/06/24.
//

import UIKit

class MusicListTableCell: UITableViewCell {
    
    @IBOutlet weak var lblMusicName: UILabel!
    @IBOutlet weak var imgMusicImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnIndicator: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
