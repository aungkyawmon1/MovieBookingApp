//
//  APiResponse.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//

import Foundation
// MARK: - APiResponse
class APiResponse<T: Decodable>: Decodable {
    let code: Int?
    let message: String?
    let data: T?
    let token: String?
//
//    init(code: Int?, message: String?, data: T?, token : String?) {
//        self.code = code
//        self.message = message
//        self.data = data
//        self.token = token
//    }
}
