//
//  CreditCardCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 23/02/2022.
//

import UIKit
import CreditCardView

class CreditCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var creditCard: UIView!
    
    var data : CardObject? {
        didSet {
            if let data = data {
                // Curve - Template
                
                let c1:UIColor = UIColor(rgb: 0x7CEA9C)
                let c2:UIColor = UIColor(rgb: 0x2FB799)
                let c3:UIColor = UIColor(rgb: 0x454851)
                let c4:UIColor = UIColor(rgb: 0x6F73D2)
                let c5:UIColor = UIColor(rgb: 0x98C1D9)
                
                let card = CreditCardView(frame: CGRect(x: 0, y: 0, width: 300, height: 200), template: .Curve(c1, c2, c3, c4, c5))

//                data.cardNumber?.separate(every: 4, with: "  ")
                card.nameLabel.text = data.cardHolder
                card.expLabel.text = data.expirationDate
                card.numLabel.text = "****   ****   ****   \(String(describing: data.cardNumber!.suffix(4)))"
                card.brandLabel.text = data.cardType
                card.brandImageView.image = UIImage()
                creditCard.addSubview(card)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
//
//extension CALayer {
//    func applySketchShadow(
//        color: UIColor = .black,
//        alpha: Float = 0.5,
//        x: CGFloat = 0,
//        y: CGFloat = 2,
//        blur: CGFloat = 4,
//        spread: CGFloat = 0)
//    {
//        shadowColor = color.cgColor
//        shadowOpacity = alpha
//        shadowOffset = CGSize(width: x, height: y)
//        shadowRadius = blur / 2.0
//        if spread == 0 {
//            shadowPath = nil
//        } else {
//            let dx = -spread
//            let rect = bounds.insetBy(dx: dx, dy: dx)
//            shadowPath = UIBezierPath(rect: rect).cgPath
//        }
//    }
//}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

