//
//  DaysCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 15/02/2022.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblShortWeek: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    var data : MyDate? {
        didSet {
            if let data = data {
                lblDay.text = "\(data.day)"
                lblShortWeek.text = data.week
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override var isSelected: Bool {
           didSet {
               if (isSelected) {
                   lblShortWeek.textColor = .white
                   lblDay.textColor = .white
               } else {
                   lblShortWeek.textColor = .black
                   lblDay.textColor = .black
               }
           }
       }

}
