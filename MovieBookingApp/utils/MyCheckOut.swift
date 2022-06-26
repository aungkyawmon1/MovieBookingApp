//
//  MyCheckOut.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 05/05/2022.
//

import Foundation
// MARK: - CinemaDayTimeSlotResponse
class MyCheckOut {
    
    static let shared = MyCheckOut()
    
    private var cinemaDayTimeslotID: Int?
    private var row, seatNumber, bookingDate, movieName, cinemaName, cinemaTime : String?
    private var totalPrice: Double?
    private var movieID, cardID, cinemaID: Int?
    private var snacks: [[String: Int?]]?
    
    private init() {}

    var _cinemaDayTimeslotID: Int {
        get {
            return cinemaDayTimeslotID ?? 0
        }
        set(cinemaDayTimeslotID) {
            self.cinemaDayTimeslotID = cinemaDayTimeslotID
        }
    }
    
    var _movieID: Int {
        get {
            return movieID ?? 0
        }
        set(movieID) {
            self.movieID = movieID
        }
    }
    
    var _bookingDate: String {
        get {
            return bookingDate ?? ""
        }
        set(bookingDate) {
            self.bookingDate = bookingDate
        }
    }
    
    var _seatNumber: String {
        get {
            return (seatNumber ?? "")
        }
        set(seatNumber) {
            self.seatNumber = seatNumber
        }
    }
    
    var _movieName: String {
        get {
            return movieName ?? ""
        }
        set(movieName) {
            self.movieName = movieName
        }
    }
    
    var _cinemaName: String {
        get {
            return cinemaName ?? ""
        }
        set(cinemaName) {
            self.cinemaName = cinemaName
        }
    }
    
    var _cinemaTime: String {
        get {
            return cinemaTime ?? ""
        }
        set(cinemaTime) {
            self.cinemaTime = cinemaTime
        }
    }
    
    var _row: String {
        get {
            return row ?? ""
        }
        set(row) {
            self.row = row
        }
    }
    
    var _totalPrice: Double {
        get {
            return totalPrice ?? 0.0
        }
        set(totalPrice) {
            self.totalPrice = totalPrice
        }
    }
    
    var _snacks: [[String: Int?]] {
        get {
            return snacks ?? [[String: Int?]]()
        }
        set(snacks) {
            self.snacks = snacks
        }
    }
    
    var _cardID: Int {
        get {
            return cardID ?? 0
        }
        set(cardID) {
            self.cardID = cardID
        }
    }
    
    var _cinemaID: Int {
        get {
            return cinemaID ?? 0
        }
        set(cinemaID) {
            self.cinemaID = cinemaID
        }
    }
    
    func getCheckOut() -> CheckOutVO {
     
        return CheckOutVO(cinemaDayTimeslotID: self.cinemaDayTimeslotID, row: self.row, seatNumber: self.seatNumber, bookingDate: self.bookingDate, totalPrice: self.totalPrice, movieID: self.movieID, cardID: self.cardID, cinemaID: self.cinemaID, snacks: snacks! )
    }
    
    func reset() {
        self.cinemaDayTimeslotID = nil
        self.movieID = nil
        self.snacks = nil
        self.row = nil
        self.seatNumber = nil
        self.bookingDate = nil
        self.movieName = nil
        self.cinemaName = nil
        self.cinemaTime = nil
        self.totalPrice = nil
        self.cardID = nil
        self.cinemaID = nil
    }
}

// MARK: - Snack
class MySnack: Codable {
    let id, quantity: Int?

    init(id: Int?, quantity: Int?) {
        self.id = id
        self.quantity = quantity
    }
}
