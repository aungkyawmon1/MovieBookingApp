//
//  CinemaObject.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 04/05/2022.
//

import Foundation
import RealmSwift
// MARK: - Datum
class CinemaObject: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var name: String?
    
    @Persisted
    var phone: String?
    
    @Persisted
    var email: String?
    
    @Persisted
    var address: String?
}
