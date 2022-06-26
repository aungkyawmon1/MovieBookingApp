//
//  LoginAndSigninRepository.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//

import Foundation

protocol LoginAndSigninRepository {
    func saveProfile(profile: ProfileObject?)
    func getProfile(id: Int, completion: @escaping (ProfileObject) -> Void)
}

class LoginAndSigninRepositoryImpl: BaseRepository, LoginAndSigninRepository {

    static let shared : LoginAndSigninRepository = LoginAndSigninRepositoryImpl()
    
    private override init() { }
    
    func saveProfile(profile: ProfileObject?) {
        guard let profile = profile else {
            return
        }
        Prefs.shared.setID(newID: profile.id!)
        do{
            try realmInstance.write {
                realmInstance.add(profile, update: .modified)
            }
        }catch {
            
        }
    }
    
    
    func getProfile(id: Int, completion: @escaping (ProfileObject) -> Void) {
        guard let profile = realmInstance.object(ofType: ProfileObject.self, forPrimaryKey: id) else {
            return
        }
        completion(profile)
    }
    
}
