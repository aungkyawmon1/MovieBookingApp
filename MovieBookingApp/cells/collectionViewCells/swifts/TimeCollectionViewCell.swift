//
//  TimeCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 15/02/2022.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewForContainerBorder: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    var cinemaData : CinemaObject? {
        didSet {
            if let data = cinemaData {
                lblName.text = data.name
            }
        }
    }
    
    var timeSlot : Timeslot? {
        didSet {
            if let data = timeSlot {
                lblName.text = data.startTime
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForContainerBorder.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewForContainerBorder.layer.borderWidth = 1
        viewForContainerBorder.layer.cornerRadius = 5
    }
    
    
    override var isSelected: Bool {
           didSet {
               if (isSelected) {
                lblName.textColor = .white
                viewForContainerBorder.backgroundColor = UIColor(named: "color_primary")
               } else {
                lblName.textColor = .black
                viewForContainerBorder.backgroundColor = .systemBackground
               }
           }
       }

}
