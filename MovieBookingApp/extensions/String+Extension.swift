//
//  String+Extension.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 07/05/2022.
//

import Foundation

extension String {

    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
        }.joined(separator: separator))
    }
}
