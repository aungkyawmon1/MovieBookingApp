//
//  MovieMockData.swift
//  MovieBookingAppTests
//
//  Created by MacBook Pro on 23/06/2022.
//

import Foundation

public final class MovieMockData {
    public static let movieSeatJsonUrl: URL = Bundle(for: MovieMockData.self).url(forResource: "movie_seat", withExtension: "json")!
}
