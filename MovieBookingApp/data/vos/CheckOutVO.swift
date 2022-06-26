//
//  CheckOutVO.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 09/05/2022.
//
import Foundation
// MARK: - CinemaDayTimeSlotResponse
struct CheckOutVO: Codable {
    let cinemaDayTimeslotID: Int?
    let row, seatNumber, bookingDate: String?
    let totalPrice: Double?
    let movieID, cardID, cinemaID: Int?
    let snacks: [[String: Int?]]

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case row
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieID = "movie_id"
        case cardID = "card_id"
        case cinemaID = "cinema_id"
        case snacks
    }
    
    
     var description: [String:Any] {
        return [
            "cinema_day_timeslot_id": cinemaDayTimeslotID!,
            "row": row!,
            "seat_number": seatNumber!,
            "booking_date": bookingDate!,
            "total_price": totalPrice!,
            "movie_id": movieID!,
            "card_id": cardID!,
            "cinema_id": cinemaID!,
            "snacks": snacks
        ]
        
     }
}
