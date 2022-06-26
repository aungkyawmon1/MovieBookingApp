//
//  MovieListCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 21/02/2022.
//

import UIKit
import SDWebImage
class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPosterPath: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    var data : MovieObject? {
        didSet {
            if let data = data {
                let backdropPath = "\(Constant.baseImageUrl)\( data.posterPath ?? "" )"
                lblTitle.text = data.originalTitle
                lblReleaseDate.text = data.releaseDate
                ivPosterPath.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
