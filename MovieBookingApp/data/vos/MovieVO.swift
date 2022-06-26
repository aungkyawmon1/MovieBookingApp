//
//  MovieVO.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 15/02/2022.
//

import Foundation
import RealmSwift

// MARK: - Datum
class Movie : Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let overview: String?
    let rating: Double?
    let runtime: Int?
    let posterPath: String?
    let casts: [Cast]?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }

    init(id: Int?, originalTitle: String?, releaseDate: String?, genres: [String]?, overview: String?, rating: Double?, runtime: Int?, posterPath: String?, casts: [Cast]?) {
        self.id = id
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
        self.rating = rating
        self.runtime = runtime
        self.posterPath = posterPath
        self.casts = casts
    }
    
    
    func toMovieObject(belongsToType : BelongsToTypeObject) -> MovieObject {
        let movieObject = MovieObject()
        movieObject.id = id
        movieObject.originalTitle = originalTitle
        movieObject.releaseDate = releaseDate
        let genresList = List<String>()
        genresList.append(objectsIn: genres ?? [String]())
        movieObject.genres = genresList
        movieObject.posterPath = posterPath
        movieObject.belongsToType.append(belongsToType)
        return movieObject
    }
}

