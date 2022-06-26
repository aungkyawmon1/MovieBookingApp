//
//  Prefs.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//

import Foundation

class Prefs {
    
    static let shared = Prefs()
    
    private let defaults = UserDefaults.standard
    
    private let keyID = "id"
    private let token = "token"
    private let seatRow = "seat_row"
    private let seatColumn = "seat_column"
  
    //For ID
    func setID(newID : Int){
        defaults.set(newID, forKey: keyID)
    }
    
    func getID() -> Int {
        return defaults.integer(forKey: keyID)
        
    }
    
    //For Token
    func setToken(newToken: String){
        defaults.set(newToken, forKey: token)
    }
    
    func getToken() -> String {
        return defaults.string(forKey: token) ?? ""
    }
    
    //For Seat Row
    func setSeatRow(count : Int){
        defaults.set(count, forKey: seatRow)
    }
    
    func getSeatRow() -> Int {
        return defaults.integer(forKey: seatRow)
        
    }
    
    //For Seat Column
    func setSeatColumn(count : Int){
        defaults.set(count, forKey: seatColumn)
    }
    
    func getSeatColumn() -> Int {
        return defaults.integer(forKey: seatColumn)
        
    }
    
    func clearAllData() {
        UserDefaults.resetDefaults()
    }
    
}
