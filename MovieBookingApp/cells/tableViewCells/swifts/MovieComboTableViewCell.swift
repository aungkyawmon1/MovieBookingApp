//
//  MovieComboTableViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 23/02/2022.
//

import UIKit
import PKYStepper

class MovieComboTableViewCell: UITableViewCell {

    @IBOutlet weak var stepper: PKYStepper!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var onTapItem : ((Int, Double, Float) -> Void) = { _,_,_ in }
    
    var count = 0
    var data : SnackObject? {
        didSet {
            if let data = data {
                lblName.text = data.name
                lblDescription.text = data.datumDescription
                lblPrice.text = "\(data.price)$"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stepper.value = 0
        stepper.stepInterval = 1
        stepper.setBorderColor(.gray)
        stepper.setButtonTextColor(.gray, for: .normal)
        stepper.setLabelTextColor(.gray)
        
        stepper.valueChangedCallback = { stepper, count in
            if Int( stepper?.countLabel.text ?? "0" ) ?? 0 < Int(count) {
                self.onTapItem(self.data?.id ?? 0, Double(self.data?.price ?? 0 ), count)
            }else {
                self.onTapItem( self.data?.id ?? 0, -Double(self.data?.price ?? 0 ), count)
            }
            stepper?.countLabel.text = "\(Int(count))"
            
         }
         stepper.setup()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
