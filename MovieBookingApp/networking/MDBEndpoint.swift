//
//  MDBEndpoint.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 24/04/2022.
//

import Foundation
import Alamofire

enum MDBEndpoint: URLConvertible {
    case register
    case emailLogin
    case facebookLogin
    case googleLogin
    case card
    case logout
    case snacks
    case profile
    case profileTransactions
    case paymentMethods
    case seatPlan(id : Int, data : String)
    case cinemaDayTimeslots(id: Int,date : String)
    case movieDetail(id: Int)
    case movieList(status : String, take : Int)
    case cinemaList
    case checkout
    
    private var baseURL : String {
        return Constant.baseURL
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url : URL {
        let urlComponents = NSURLComponents(string: baseURL.appending(apiPath))
        return urlComponents!.url!
    }
    
    var apiPath : String {
        switch self {
        case .register:
            return "register"
        case .emailLogin:
            return "email-login"
        case .facebookLogin:
            return "facebook-login"
        case .googleLogin:
            return "google-login"
        case .card:
            return "card"
        case .logout:
            return "logout"
        case .snacks:
            return "snacks"
        case .profile:
            return "profile"
        case .profileTransactions:
            return "profile/transactions"
        case .paymentMethods:
            return "payment-methods"
        case .seatPlan(let id, let data):
            return "seat-plan?cinema_day_timeslot_id=\(id)&booking_date=\(data)"
        case .cinemaDayTimeslots(let id,let date):
            return "cinema-day-timeslots?movie_id=\(id)&date=\(date)"
        case .movieDetail(let id):
            return "movies/\(id)"
        case .movieList(let status, let take):
            return "movies?status=\(status)&take=\(take)"
        case .cinemaList:
            return "cinemas"
        case .checkout:
            return "checkout"
        }
    }
}
