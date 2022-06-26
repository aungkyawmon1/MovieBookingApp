//
//  MovieRepository.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 27/04/2022.
//

import Foundation
import RealmSwift

protocol MovieRepository {
    func saveList(type: MovieSerieGroupType, data: [Movie])
    func saveDetail(id: Int,movie : Movie)
    func getDetail(id: Int, completion: @escaping (MovieObject) -> Void)
}



class MovieRepositoryImpl: BaseRepository, MovieRepository {
  
    static let shared : MovieRepository = MovieRepositoryImpl()
    let contentTypeRepo = ContentTypeRepositoryImpl.shared
    
    private override init() { }
    
    func saveList(type: MovieSerieGroupType, data: [Movie]) {

       // print(Realm.Configuration.defaultConfiguration.fileURL!)
        guard let belongToTypeObject = realmInstance.object(ofType: BelongsToTypeObject.self, forPrimaryKey: type.rawValue) else { return  }
        let movieList = data.map { movie -> MovieObject in
            return movie.toMovieObject(belongsToType: belongToTypeObject)
        }
        
        do {
            try realmInstance.write {
                realmInstance.add(movieList, update: .modified)
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getDetail(id: Int, completion: @escaping (MovieObject) -> Void) {
        guard let movieObject = realmInstance.object(ofType: MovieObject.self, forPrimaryKey: id) else { return }
        completion(movieObject)
    }
    
    func saveDetail(id: Int, movie : Movie) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let movieObject = realmInstance.object(ofType: MovieObject.self, forPrimaryKey: id)
        if let castList = movie.casts {
            do {
                try realmInstance.write {
                    realmInstance.add( castList, update: .modified)
                    movieObject?.overview = movie.overview
                    movieObject?.rating = movie.rating
                    movieObject?.runtime = movie.runtime
                    movieObject?.casts.append(objectsIn: castList)
                }
            }catch {
                print(error.localizedDescription)
            }
        }else {
            do {
                try realmInstance.write {
                    movieObject?.overview = movie.overview
                    movieObject?.rating = movie.rating
                    movieObject?.runtime = movie.runtime
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
