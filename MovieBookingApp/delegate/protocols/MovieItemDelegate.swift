//
//  MovieItemDelegate.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 24/02/2022.
//

import Foundation

protocol MovieItemDelegate : AnyObject {
    func onTapMovie(id : Int)
}
