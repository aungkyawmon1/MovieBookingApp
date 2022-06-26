//
//  GenreCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 22/02/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewForGenre: UIView!
    
    @IBOutlet weak var lblGenreTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForGenre.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewForGenre.layer.borderWidth = 1
        viewForGenre.layer.cornerRadius = 20
    }

    func bindData(title : String){
        lblGenreTitle.text = title
    }
}
