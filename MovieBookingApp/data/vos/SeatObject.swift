// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieListResponse = try? newJSONDecoder().decode(MovieListResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Datum
class SeatObject: Object, Codable {
    
    @Persisted(primaryKey: true)
    var seatId : String
    
    @Persisted
    var timeSlotAndDate: String
    
    @Persisted
    var id: Int?
    
    @Persisted
    var type: String?
    
    @Persisted
    var seatName: String?
    
    @Persisted
    var symbol: String?
    
    @Persisted
    var price: Int?
    
    override init() {
        
    }
    
    init(id: Int?, type: String?, seatName: String?, symbol: String?, price: Int?) {
          self.id = id
          self.type = type
          self.seatName = seatName
          self.symbol = symbol
          self.price = price
      }

    enum CodingKeys: String, CodingKey {
        case id, type
        case seatName = "seat_name"
        case symbol, price
    }
    
    func isMovieSeatAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isMovieSeatTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    func isMovieSeatRowTitle() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
    
}
