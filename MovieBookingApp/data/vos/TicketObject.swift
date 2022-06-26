import Foundation
import RealmSwift
// MARK: - DataClass
class TicketObject: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var bookingNo: String?
    
    @Persisted
    var bookingDate: String?
    
    @Persisted
    var row: String?
    
    @Persisted
    var seat: String?
    
    @Persisted
    var totalSeat: Int?
    
    @Persisted
    var total: String?
    
    @Persisted
    var movieID: Int?
    
    @Persisted
    var cinemaID: Int?
    
    @Persisted
    var username: String?
    
    @Persisted
    var timeslot: Timeslot?
    
    @Persisted
    var snacks: List<SnackObject>
    
    @Persisted
    var qrCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingNo = "booking_no"
        case bookingDate = "booking_date"
        case row, seat
        case totalSeat = "total_seat"
        case total
        case movieID = "movie_id"
        case cinemaID = "cinema_id"
        case username, timeslot, snacks
        case qrCode = "qr_code"
    }
}
