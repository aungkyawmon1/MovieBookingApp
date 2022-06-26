//
//  MoviePaymentTableViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 23/02/2022.
//

import UIKit

class MoviePaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCard: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var data : PaymentMethodObject? {
        didSet {
            if let data = data {
                lblCard.text = data.name
                lblDescription.text = data.datumDescription
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
