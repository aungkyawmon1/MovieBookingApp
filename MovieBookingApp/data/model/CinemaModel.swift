//
//  CinemaDayTimeSlotModel.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 04/05/2022.
//

import Foundation

protocol CinemaModel {
    func getCinemaDayTimeSlot(id: Int,date : String,completion : @escaping (MDBResult<[CinemaDayTimeSlotObject]>) -> Void )
    func getCinema(completion : @escaping (MDBResult<[CinemaObject]>) -> Void )
    func getCinemaById(id: Int, completion: @escaping (MDBResult<CinemaObject>) -> Void )
    func getSeatPlan(movieID: Int, timeSlot: Int, for date: String,time: String, completion: @escaping (MDBResult<[SeatObject]>) -> Void )
}

class CinemaModelImpl : BaseModel, CinemaModel {
    
    static let shared = CinemaModelImpl()
    let cinemaRepository : CinemaRepository = CinemaRepositoryImpl.shared
    
    private override init() { }
    
    func getCinemaDayTimeSlot(id: Int,date: String, completion: @escaping (MDBResult<[CinemaDayTimeSlotObject]>) -> Void) {
        let dateAndId = "\(date)_\(id)"
        networkAgent.getCinemaDayTimeSlot(id: id, date: date) { (result) in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveCinemaDayTimeSlot(dateAndID: dateAndId, data: data)
            case .failure(let message):
                print("\(message)")
            }
            self.cinemaRepository.getCinemaDayTimeSlots(dateAndID: dateAndId) {
                completion(.success($0))
                
            }
            
        }
    }
    
    func getCinema(completion: @escaping (MDBResult<[CinemaObject]>) -> Void) {
        networkAgent.getCinema { result in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveCinema(data: data)
            case .failure(let message):
                print("\(message)")
            }
            self.cinemaRepository.getCinema {
                completion(.success($0))
            }
        }
    }
    
    func getSeatPlan(movieID: Int, timeSlot: Int, for date: String,time: String, completion: @escaping (MDBResult<[SeatObject]>) -> Void) {
        let timeSlotDate = "\(movieID)_\(timeSlot)_\(date)_\(time)"
        networkAgent.getSeatPlan(cinemaDayTimeSlot: timeSlot, bookingDate: date) { result in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveSeatPlan(timeSlotAndDate: timeSlotDate, data: data)
            case .failure(let message):
                print("\(message)")
            }
            self.cinemaRepository.getSeatPlan(timeSlotAndDate: timeSlotDate){ completion(.success($0))}
        }
    }
    
    func getCinemaById(id: Int, completion: @escaping (MDBResult<CinemaObject>) -> Void) {
        cinemaRepository.getCinemaById(id: id) { completion(.success( $0 ))}
    }
    
}

