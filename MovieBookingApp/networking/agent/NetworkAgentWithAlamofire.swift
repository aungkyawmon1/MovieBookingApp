//
//  NetworkAgentWithAlamofire.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 25/04/2022.
//

import Foundation
import Alamofire

protocol MovieDBNetworkAgentProtocol {
    func register(email: String, password: String, phone: String, username: String, googleToken: String, facebookToken: String, completion: @escaping (MDBResult<APiResponse<ProfileObject>>) -> Void )
    func logInWithEmail(email : String, password: String, completion: @escaping (MDBResult<APiResponse<ProfileObject>>) -> Void)
    func logInWithGoogle(token : String, completion: @escaping (MDBResult<APiResponse<ProfileObject>>) -> Void)
    func logout(completion: @escaping (MDBResult<Bool>) -> Void )
    func getMovieList(status: String, completion: @escaping (MDBResult<[Movie]>) -> Void)
    func getDetail(id : Int, completion: @escaping (MDBResult<Movie>) -> Void )
    func getCinemaDayTimeSlot(id : Int, date : String, completion: @escaping (MDBResult<[CinemaDayTimeSlotObject]>) -> Void )
    func getCinema(completion: @escaping (MDBResult<[CinemaObject]>) -> Void )
    func getSeatPlan(cinemaDayTimeSlot: Int, bookingDate: String, completion: @escaping (MDBResult<[[SeatObject]]>) -> Void )
    func getSnacks(completion: @escaping (MDBResult<[SnackObject]>) -> Void )
    func getPaymentMethod(completion: @escaping (MDBResult<[PaymentMethodObject]>) -> Void)
    func registerCard(cardNumber: String, cardHolder: String, expirationDate: String, cvc: String, completion: @escaping (MDBResult<[CardObject]>) -> Void )
    func registerTicket(checkOut: CheckOutVO, completion: @escaping (MDBResult<TicketObject>) -> Void )
}

struct MovieDBNetworkAgent: MovieDBNetworkAgentProtocol {
    
    static let shared = MovieDBNetworkAgent()
    
    private init() { }
    
    func register(email: String, password: String, phone: String, username: String, googleToken: String, facebookToken: String, completion: @escaping (MDBResult<APiResponse<ProfileObject>>) -> Void) {
        let parameters : [String : String ] = ["email": email, "password": password, "phone": phone, "name": username, "google-access-token": googleToken, "facebook-access-token":facebookToken]
        AF.request(MDBEndpoint.register, method: .post, parameters: parameters)
            .responseDecodable(of: APiResponse<ProfileObject>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500 ) {
                        completion(.success(result))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    
    func logInWithEmail(email: String, password: String, completion: @escaping (MDBResult<APiResponse<ProfileObject>>) -> Void) {
        let parameters : [String : String ] = ["email": email, "password": password ]
        AF.request(MDBEndpoint.emailLogin, method: .post, parameters: parameters)
            .responseDecodable(of: APiResponse<ProfileObject>.self) { response in
                switch response.result {
                case .success(let result):
                    
                    if isCodeInRange(result.code ?? 500 ) {
                        completion(.success(result))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
        
    }
    
    func logInWithGoogle(token: String, completion: @escaping (MDBResult<APiResponse<ProfileObject>>) -> Void) {
        let parameters : [String : String ] = ["access-token": token]
        AF.request(MDBEndpoint.googleLogin, method: .post, parameters: parameters)
            .responseDecodable(of: APiResponse<ProfileObject>.self) { response in
                switch response.result {
                case .success(let result):
                    
                    if isCodeInRange(result.code ?? 500 ) {
                        completion(.success(result))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func getMovieList(status: String, completion: @escaping (MDBResult<[Movie]>) -> Void) {
        AF.request(MDBEndpoint.movieList(status: status, take: 10))
            .responseDecodable(of: APiResponse<[Movie]>.self) { response in
               
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500 ) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
                
            }
    }
    
    func logout(completion: @escaping (MDBResult<Bool>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        AF.request(MDBEndpoint.logout,method: .post, headers:  headers)
            .responseDecodable(of: APiResponse<Bool>.self) {  response in
                
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500 ) {
                        completion(.success(true))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    
    func getDetail(id: Int, completion: @escaping (MDBResult<Movie>) -> Void) {
        AF.request(MDBEndpoint.movieDetail(id: id))
            .responseDecodable(of: APiResponse<Movie>.self) { response in
                
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func getCinema(completion: @escaping (MDBResult<[CinemaObject]>) -> Void) {
        AF.request(MDBEndpoint.cinemaList)
            .responseDecodable(of: APiResponse<[CinemaObject]>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    
    func getCinemaDayTimeSlot(id: Int, date: String, completion: @escaping (MDBResult<[CinemaDayTimeSlotObject]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        AF.request(MDBEndpoint.cinemaDayTimeslots(id: id, date: date), headers: headers)
            .responseDecodable(of: APiResponse<[CinemaDayTimeSlotObject]>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func getSeatPlan(cinemaDayTimeSlot: Int, bookingDate: String, completion: @escaping (MDBResult<[[SeatObject]]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        AF.request(MDBEndpoint.seatPlan(id: cinemaDayTimeSlot, data: bookingDate), headers: headers)
            .responseDecodable(of: APiResponse<[[SeatObject]]>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func getSnacks(completion: @escaping (MDBResult<[SnackObject]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        AF.request(MDBEndpoint.snacks, headers: headers)
            .responseDecodable(of: APiResponse<[SnackObject]>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func getPaymentMethod(completion: @escaping (MDBResult<[PaymentMethodObject]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        AF.request(MDBEndpoint.paymentMethods, headers: headers)
            .responseDecodable(of: APiResponse<[PaymentMethodObject]>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func registerCard(cardNumber: String, cardHolder: String, expirationDate: String, cvc: String, completion: @escaping (MDBResult<[CardObject]>) -> Void) {
        let headers:  HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        let parameters : [String : String ] = ["card_number": cardNumber, "card_holder": cardHolder, "expiration_date": expirationDate, "cvc": cvc]
        AF.request(MDBEndpoint.card, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: APiResponse<[CardObject]>.self) {  response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func registerTicket(checkOut: CheckOutVO, completion: @escaping (MDBResult<TicketObject>) -> Void) {
        let headers:  HTTPHeaders = [.authorization(bearerToken: Prefs.shared.getToken())]
        AF.request(MDBEndpoint.checkout,
                            method: .post,
                            parameters: checkOut.description,
                            encoding:  JSONEncoding.default,
                            headers: headers)
            .responseDecodable(of: APiResponse<TicketObject>.self) { response in
                switch response.result {
                case .success(let result):
                    if isCodeInRange(result.code ?? 500) {
                        completion(.success(result.data!))
                    }else {
                        completion(.failure(result.message ?? "Please try again!"))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
       
        
    }
    
    // MARK: Helper methods
       private func noInternet(error: AFError) -> Bool {
           if let error = error.underlyingError {
               if let urlError = error as? URLError {
                   switch urlError.code {
                   case .notConnectedToInternet:
                       return true
                   default:
                       return false
                   }
               }
           }
           return false
       }
    
    private func handleError(_ error: AFError) -> String {
           if (noInternet(error: error)) {
               return "Please connect to the internet"
           } else {
               return error.localizedDescription
           }
       }
    
    private func isCodeInRange(_ code: Int) -> Bool{
        return (200..<300).contains(code)
    }
    
}

enum MDBResult<T> {
    case success(T)
    case failure(String)
}
