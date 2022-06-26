//
//  LoginAndSigninModel.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//

import Foundation

protocol LoginAndSigninModel {
    func registerWithEmail(email : String, password : String, phone: String, username: String, googleToken: String, facebookToken: String, completion : @escaping (MDBResult<ProfileObject>) -> Void)
    func getLogin(email : String, password : String, completion : @escaping (MDBResult<ProfileObject>) -> Void)
    func getLoginWithGoogle(token: String,completion: @escaping (MDBResult<ProfileObject>) -> Void )
    func logout(completion: @escaping (MDBResult<Bool>) -> Void )
    func getProfile(completion: @escaping (MDBResult<ProfileObject>) -> Void)
}

class LoginAndSigninModelImpl: BaseModel, LoginAndSigninModel {
  
    static let shared = LoginAndSigninModelImpl()
    
    let loginAndSiginRepository = LoginAndSigninRepositoryImpl.shared
    
    func registerWithEmail(email: String, password: String, phone: String, username: String, googleToken: String, facebookToken: String, completion: @escaping (MDBResult<ProfileObject>) -> Void) {
        networkAgent.register(email: email, password: password, phone: phone, username: username, googleToken: googleToken , facebookToken: facebookToken ) {  (result) in
            switch result {
            case.success(let data):
                Prefs.shared.setToken(newToken: data.token ?? "")
                self.loginAndSiginRepository.saveProfile(profile: data.data)
            case .failure(let message):
                completion(.failure(message))
            }
            self.loginAndSiginRepository.getProfile(id: Prefs.shared.getID()) {
                completion(.success($0))
            }
        }
    }
    

    func getLogin(email: String, password: String, completion: @escaping (MDBResult<ProfileObject>) -> Void) {
        networkAgent.logInWithEmail(email: email, password: password) { (result) in
            switch result {
            case.success(let data):
                Prefs.shared.setToken(newToken: data.token ?? "")
                self.loginAndSiginRepository.saveProfile(profile: data.data)
            case .failure(let message):
                completion(.failure(message))
            }
            self.loginAndSiginRepository.getProfile(id: Prefs.shared.getID()) {
                completion(.success($0))
            }
        }
        
    }
    
    func getLoginWithGoogle(token: String, completion: @escaping (MDBResult<ProfileObject>) -> Void) {
        networkAgent.logInWithGoogle(token: token) { (result) in
            switch result {
            case.success(let data):
                Prefs.shared.setToken(newToken: data.token ?? "")
                self.loginAndSiginRepository.saveProfile(profile: data.data)
            case .failure(let message):
                completion(.failure(message))
            }
            self.loginAndSiginRepository.getProfile(id: Prefs.shared.getID()) {
                completion(.success($0))
            }
        }
    }
    
    func logout(completion: @escaping (MDBResult<Bool>) -> Void) {
        networkAgent.logout { (result) in
            switch result {
            case.success(let data):
                completion(.success(data))
            case .failure(let message):
                completion(.failure(message))
            }
        }
    }
    
    
    func getProfile(completion: @escaping (MDBResult<ProfileObject>) -> Void) {
        loginAndSiginRepository.getProfile(id: Prefs.shared.getID()) {
            completion(.success($0))
        }
    }

}
