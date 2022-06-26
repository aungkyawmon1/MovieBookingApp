//
//  ContentTypeRepository.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 27/04/2022.
//

import Foundation

protocol ContentTypeRepository {
    func initializeData()
    func save(name : String) -> BelongsToTypeObject
    func getMoviesOrSeries(type : MovieSerieGroupType, completion: @escaping ([MovieObject]) -> Void)
}

class ContentTypeRepositoryImpl: BaseRepository, ContentTypeRepository {

    static let shared : ContentTypeRepository = ContentTypeRepositoryImpl()
    private override init() {
        super.init()
        initializeData()
        
    }
    
    func initializeData() {
        // Process Existing Data
        
        let categories = realmInstance.objects(BelongsToTypeObject.self)
        
        if categories.isEmpty {
            MovieSerieGroupType.allCases.forEach {
                let _ = save(name: $0.rawValue)
            }
        }
    }
    
    func save(name: String) -> BelongsToTypeObject {
        let object = BelongsToTypeObject()
        object.name = name
        
        do {
            try realmInstance.write {
                realmInstance.add(object)
            }
        }catch {
            print(error.localizedDescription)
        }
        return object
    }
    
    func getMoviesOrSeries(type: MovieSerieGroupType, completion: @escaping ([MovieObject]) -> Void) {
//        if let object = contentTypeMap[type.rawValue] {
//            let movieObject = realmInstance.objects(MovieObject.self)
//                .filter(NSPredicate(format: "ANY belongsToType == %@", object))
//            completion(movieObject.map{ $0 })
//        }else {
            let object = realmInstance.object(ofType: BelongsToTypeObject.self, forPrimaryKey: type.rawValue)
            let movieObject = realmInstance.objects(MovieObject.self)
                .filter(NSPredicate(format: "ANY belongsToType == %@", object!))
            completion(movieObject.map{ $0 })
        
    }
 
}
