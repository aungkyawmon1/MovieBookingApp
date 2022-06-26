//
//  SnackListResponse.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 25/04/2022.
//

import Foundation
import RealmSwift

// MARK: - Datum
class SnackObject: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var datumDescription: String
    
    @Persisted
    var price: Int
    
    @Persisted
    var image: String
    
    @Persisted
    var unitPrice : Int?
    
    @Persisted
    var quantity: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case price, image
        case unitPrice = "unit_price"
        case quantity
    }
    
  
}
