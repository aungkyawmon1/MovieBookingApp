//
//  BaseModel.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 26/04/2022.
//

import Foundation

class BaseModel: NSObject {
    let networkAgent : MovieDBNetworkAgentProtocol = MovieDBNetworkAgent.shared
}
