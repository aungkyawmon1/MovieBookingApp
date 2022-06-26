//
//  PaymentMethodListResponse.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 25/04/2022.
//

import Foundation
import RealmSwift

// MARK: - Datum
class PaymentMethodObject: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String?
    
    @Persisted
    var datumDescription: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
    }
}
