//
//  CardResponse.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 25/04/2022.
//

import Foundation
import RealmSwift

// MARK: - Card
class CardObject: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var cardHolder: String?
    
    @Persisted
    var cardNumber: String?
    
    @Persisted
    var expirationDate: String?
    
    @Persisted
    var cardType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType = "card_type"
    }
}
