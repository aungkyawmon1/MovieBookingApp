//
//  CastCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 22/02/2022.
//

import UIKit
import SDWebImage

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPosterPath: UIImageView!
    var data : Cast? {
        didSet {
            if let data = data {
                let profilePath = "\(Constant.baseImageUrl)\( data.profilePath ?? "" )"
                ivPosterPath.sd_setImage(with: URL(string: profilePath))
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
