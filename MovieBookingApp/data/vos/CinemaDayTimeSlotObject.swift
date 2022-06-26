// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaDayTimeSlotResponse = try? newJSONDecoder().decode(CinemaDayTimeSlotResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Datum
class CinemaDayTimeSlotObject: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id_date_movieId : String?
    
    @Persisted
    var dateAndId : String?
    
    @Persisted
    var cinemaID: Int?
   
    @Persisted
    var cinema: String?
   
    @Persisted
    var timeslots: List<Timeslot>
  
    
    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }

}

// MARK: - Timeslot
class Timeslot: Object, Codable {
    @Persisted(primaryKey: true)
    var cinemaDayTimeslotID: Int?
    
    @Persisted
    var startTime: String?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
}
