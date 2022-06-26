//
//  MovieSeatCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 15/02/2022.
//

import UIKit

class MovieSeatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContainerMovieSeat: UIView!
    @IBOutlet weak var lblMovieSeatTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
          didSet {
            if movieSeat?.isMovieSeatAvailable() ?? false {
                if (isSelected) {
                    viewContainerMovieSeat.backgroundColor = UIColor(named: "color_primary")
                } else {
                    viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color")
                }
            }
          }
      }
    
    var movieSeat : SeatObject?  {
        
        didSet{
            if let movieSeat = movieSeat {
                if movieSeat.isMovieSeatRowTitle() {
                    //Title
                    lblMovieSeatTitle.text = movieSeat.symbol
                    viewContainerMovieSeat.layer.cornerRadius = 0
                    viewContainerMovieSeat.backgroundColor = UIColor.white
                }else if movieSeat.isMovieSeatTaken() {
                    //Taken
                    viewContainerMovieSeat.clipsToBounds = true
                    viewContainerMovieSeat.layer.cornerRadius = 4
                    viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                    viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_taken_color") ?? UIColor.gray
                }else if movieSeat.isMovieSeatAvailable() {
                    //Available
                    viewContainerMovieSeat.clipsToBounds = true
                    viewContainerMovieSeat.layer.cornerRadius = 4
                    viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                    viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color") ?? UIColor.lightGray
                }else{
                    viewContainerMovieSeat.layer.cornerRadius = 0
                    viewContainerMovieSeat.backgroundColor = UIColor.white
                }
            }
        }
    }

}
