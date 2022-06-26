//
//  View+Extension.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 21/02/2022.
//

import UIKit

extension UILabel {
    
    func underlineText(text : String) {
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}

extension UITableViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UIViewController {
    static var identifier : String {
        String(describing: self)
    }
}

extension UITableView {
    
    func registerForCell(identifier : String){
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(identifier: String, indexPath : IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
}


extension UICollectionView {
    
    func registerForCell(identifier : String){
       register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UICollectionViewCell>(identifier: String, indexPath : IndexPath)->T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}

extension UIView {

  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.1
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowRadius = 15
    layer.cornerRadius = 15
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  func dropShadow(color: UIColor, opacity: Float = 0.1, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
