//
//  SearchTableViewCell.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var viewSearch: UIView!
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var imageSearch: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


        tfSearch.borderStyle = .none
        tfSearch.attributedPlaceholder =
        NSAttributedString(string: " Search here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])

        viewSearch.applyCornerRadius(radius: 20)
        viewSearch.layer.shadowColor = UIColor.lightGray.cgColor
        viewSearch.layer.shadowOpacity = 0.1
        viewSearch.layer.shadowRadius = 5
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
