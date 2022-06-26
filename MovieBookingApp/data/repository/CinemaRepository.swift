//
//  LoginAndSigninRepository.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//

import Foundation

protocol CinemaRepository {
    func saveCinemaDayTimeSlot(dateAndID: String, data : [CinemaDayTimeSlotObject])
    func getCinemaDayTimeSlots(dateAndID: String, completion: @escaping ([CinemaDayTimeSlotObject]) -> Void)
    func saveCinema(data : [CinemaObject])
    func getCinema(completion: @escaping ([CinemaObject]) -> Void)
    func getCinemaById(id: Int, completion: @escaping (CinemaObject) -> Void )
    func saveSeatPlan(timeSlotAndDate : String, data: [[SeatObject]])
    func getSeatPlan(timeSlotAndDate: String, completion: @escaping ([SeatObject]) -> Void )
}

class CinemaRepositoryImpl: BaseRepository, CinemaRepository {

    static let shared : CinemaRepository = CinemaRepositoryImpl()
    
    private override init() { }
    
    func saveCinemaDayTimeSlot(dateAndID: String, data : [CinemaDayTimeSlotObject]) {
        let cinemaList = data.map { cinema -> CinemaDayTimeSlotObject in
            cinema.id_date_movieId = "\(String(describing: cinema.cinemaID))_\(dateAndID)"
            cinema.dateAndId = dateAndID
            return cinema
        }
        do {
            try realmInstance.write({
                realmInstance.add(cinemaList, update: .modified)
                })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCinemaDayTimeSlots( dateAndID: String, completion: @escaping ([CinemaDayTimeSlotObject]) -> Void) {
          let data: [CinemaDayTimeSlotObject] = realmInstance.objects(CinemaDayTimeSlotObject.self)
            .filter { $0.dateAndId == dateAndID }
          completion(data)
      }
    
    func getCinema(completion: @escaping ([CinemaObject]) -> Void) {
        let cinemas = realmInstance.objects(CinemaObject.self)
        completion(cinemas.map { $0 })
    }
    
    func saveCinema(data: [CinemaObject]) {
        do {
            try realmInstance.write ({
                realmInstance.add(data, update: .modified)
            } )
        }catch {
            print(error.localizedDescription)
        }
    }

    func saveSeatPlan( timeSlotAndDate: String, data: [[SeatObject]]) {
        if data.count > 0 {
            Prefs.shared.setSeatColumn(count: data.count)
            Prefs.shared.setSeatRow(count: data.first?.count ?? 0)
        }
        let seat : [SeatObject] = Array(data.joined())
        var count = 0
        let seatObject = seat.map { seat -> SeatObject in
            count += 1
            seat.seatId = "\(count)_\(timeSlotAndDate)"
            seat.timeSlotAndDate = timeSlotAndDate
            return seat
        }
        do {
            try realmInstance.write({
                realmInstance.add(seatObject, update: .modified)
            })
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getSeatPlan(timeSlotAndDate: String, completion: @escaping ([SeatObject]) -> Void) {
        let seatObject: [SeatObject] = realmInstance.objects(SeatObject.self)
            .filter { $0.timeSlotAndDate == timeSlotAndDate }
        completion(seatObject)
    }
    
    func getCinemaById(id: Int, completion: @escaping (CinemaObject) -> Void) {
        guard let cinemaObject = realmInstance.object(ofType: CinemaObject.self, forPrimaryKey: id) else { return }
        completion(cinemaObject)
    }
    
}
