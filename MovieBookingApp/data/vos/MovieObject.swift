// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieListResponse = try? newJSONDecoder().decode(MovieListResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - DataClass
class MovieObject: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var originalTitle: String?
    
    @Persisted
    var releaseDate: String?
   
    @Persisted
    var genres: List<String>
   
    @Persisted
    var overview: String?
   
    @Persisted
    var rating: Double?
    
    @Persisted
    var runtime: Int?
    
    @Persisted
    var posterPath: String?
    
    @Persisted
    var casts: List<Cast>
    
    @Persisted
    var belongsToType: List<BelongsToTypeObject>

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }
    
    func getRuntimeFormat() -> String {
        if let runtime = runtime {
            let hour =  runtime / 60
            let min = runtime % 60
            return "\(hour)hr \(min)m"
        }
       return ""
    }
}

// MARK: - Cast
class Cast: Object, Codable {
    
    @Persisted
    var adult: Bool?
    
    @Persisted
    var gender: Int?
    
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var knownForDepartment: String?
    
    @Persisted
    var name: String?
    
    @Persisted
    var originalName: String?
    
    @Persisted
    var popularity: Double?
    
    @Persisted
    var profilePath: String?
    
    @Persisted
    var castID: Int?
    
    @Persisted
    var character: String?
    
    @Persisted
    var creditID: String?
    
    @Persisted
    var order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
    
  
}
