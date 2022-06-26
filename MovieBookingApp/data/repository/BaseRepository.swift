//
//  BaseRepository.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//


import Foundation
import RealmSwift

class BaseRepository: NSObject {
    
    override init() {
        super.init()
    }
    
    let realmInstance = try! Realm()

    func clearAllData() {
        // Delete all objects from the realm
        
        try! realmInstance.write {
            realmInstance.deleteAll()
        }
        ContentTypeRepositoryImpl.shared.initializeData()
    }
    
}

