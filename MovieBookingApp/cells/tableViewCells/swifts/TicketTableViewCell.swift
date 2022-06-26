//
//  TicketTableViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 11/05/2022.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBookingNo: UILabel!
    @IBOutlet weak var lblBookingDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var ticket : TicketObject? {
        didSet {
            if let data = ticket {
                lblBookingNo.text = data.bookingNo
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-DD"
                let date = dateFormatter.date(from:  data.bookingDate ?? "")

                dateFormatter.dateFormat = "EEE MMM d yyyy"
                let date1 = dateFormatter.string(from: date!)
                lblBookingDate.text = "\(date1) \(String(describing: data.timeslot!.startTime!))"
                lblPrice.text = "\(String(describing: data.total!))"
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
