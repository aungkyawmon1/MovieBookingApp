//
//  HomeTitleTableViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 21/02/2022.
//

import UIKit
import SDWebImage

class HomeTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    
    var data : ProfileObject? {
        didSet{
            if let data = data {
                let profilePath = "\(Constant.profileURL)\(data.profileImage ?? "")"
                ivProfileImage.sd_setImage(with: URL(string: profilePath))
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

