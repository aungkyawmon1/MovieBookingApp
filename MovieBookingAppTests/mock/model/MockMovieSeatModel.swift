//
//  MockMovieSeatModel.swift
//  MovieBookingAppTests
//
//  Created by MacBook Pro on 23/06/2022.
//

import Foundation
@testable import MovieBookingApp

class MockMovieSeatModel : CinemaModel {
    var isSeatEmpty = false
    func getCinemaDayTimeSlot(id: Int, date: String, completion: @escaping (MDBResult<[CinemaDayTimeSlotObject]>) -> Void) {
        
    }
    
    func getCinema(completion: @escaping (MDBResult<[CinemaObject]>) -> Void) {
        
    }
    
    func getCinemaById(id: Int, completion: @escaping (MDBResult<CinemaObject>) -> Void) {
        
    }
    
    func getSeatPlan(movieID: Int, timeSlot: Int, for date: String, time: String, completion: @escaping (MDBResult<[SeatObject]>) -> Void) {
        if !isSeatEmpty {
            let seatDataJson: Data = try! Data(contentsOf: MovieMockData.movieSeatJsonUrl)
            let seatResponseData: APiResponse<[[SeatObject]]> = try! JSONDecoder().decode(APiResponse<[[SeatObject]]>.self, from: seatDataJson)
            let seat : [SeatObject] = Array(seatResponseData.data!.joined())
            completion(.success(seat))
        }else {
            completion(.failure("no data"))
        }
        
    }
    
    
}
