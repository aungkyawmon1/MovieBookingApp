//
//  UserDefaults+Extension.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 28/04/2022.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
