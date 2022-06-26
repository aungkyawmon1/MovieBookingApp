//
//  MovieSeatViewModel.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 19/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

enum MovieSeatViewState {
    case success
    case failure(message: String)
}

class MovieSeatViewModel {

    let disposeBag = DisposeBag()
    let viewState = BehaviorRelay<MovieSeatViewState?>(value: nil)
    private let cinemaModel : CinemaModel
    private var movieSeats : [SeatObject]?
    private var selectedMovieSeats = [SeatObject]()
    private let myCheckOut: MyCheckOut
    var row = ""
    var seatNumbber = ""
    var totalTicketPrice = 0.0
    init(cinemaModel: CinemaModel, myCheckOut: MyCheckOut){
        self.cinemaModel = cinemaModel
        self.myCheckOut = myCheckOut
    }
    
    var movieName : String {
        myCheckOut._movieName
    }
    
    var cinemaName: String {
        myCheckOut._cinemaName
    }
   

    func getDateAndTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let date = dateFormatter.date(from:  myCheckOut._bookingDate)

        dateFormatter.dateFormat = "EEE MMM d yyyy"
        let goodDate = dateFormatter.string(from: date!)
        return "\(goodDate), \(myCheckOut._cinemaTime)"
    }
    
    func updateElements() {
        row = Set(selectedMovieSeats.map { $0.symbol ?? "" }).joined(separator: ",")
        seatNumbber = selectedMovieSeats.map { $0.seatName ?? "" }.joined(separator: ",")
        totalTicketPrice = 0.0
        selectedMovieSeats.forEach { totalTicketPrice += Double($0.price ?? 0) }
    }
    
    func getSeatPlan(){
        cinemaModel.getSeatPlan(movieID: myCheckOut._movieID, timeSlot: myCheckOut._cinemaDayTimeslotID, for: myCheckOut._bookingDate ,time: myCheckOut._cinemaTime) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.movieSeats = data
                self.viewState.accept(.success)
            case .failure(let message):
                self.viewState.accept(.failure(message: message))
            }
            
        }
    }
    
    func getSelectedMovieSeatsCount() -> Int {
        return selectedMovieSeats.count
    }
    
    func getMovieSeatCount()-> Int {
        return movieSeats?.count ?? 0
    }
    
    func getMovieType(_ id: Int) -> String {
        return movieSeats?[id].type ?? ""
    }
    
    func addSelectedMovieSeat(newSeat: SeatObject){
        selectedMovieSeats.append(newSeat)
    }
    
    func removeSelectedMovieSeat(seat: SeatObject){
        if let index = selectedMovieSeats.firstIndex(of: seat) {
            selectedMovieSeats.remove(at: index)
        }
    }
    
    func getMovieSeat(_ index: Int) -> SeatObject{
        return movieSeats?[index] ?? SeatObject()
    }
    
    func setMyCheckOut() {
        myCheckOut._row = row
        myCheckOut._seatNumber = seatNumbber
        myCheckOut._totalPrice = totalTicketPrice
    }
    
    
    
}
