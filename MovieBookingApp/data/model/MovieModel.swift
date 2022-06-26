//
//  MovieModel.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 27/04/2022.
//

import Foundation

protocol MovieModel {
    func getMovieList(status : String,completion : @escaping (MDBResult<[MovieObject]>) -> Void )
    func getDetail(id : Int, completion : @escaping (MDBResult<MovieObject>) -> Void)
    func getDetailOffline(id : Int, completion : @escaping (MDBResult<MovieObject>) -> Void)
}

class MovieModelImpl: BaseModel, MovieModel {

    static let shared = MovieModelImpl()
    let contentTypeRepository : ContentTypeRepository = ContentTypeRepositoryImpl.shared
    let movieRepository : MovieRepository = MovieRepositoryImpl.shared
    private override init() { }
    
    
    func getMovieList(status: String, completion: @escaping (MDBResult<[MovieObject]>) -> Void) {
     
        let type = (status == "nowshowing") ? MovieSerieGroupType.nowShowing : MovieSerieGroupType.comingSoon
       // print(type.rawValue)
        networkAgent.getMovieList(status: status) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveList(type: type, data: data)
            case .failure(let message):
                print("\(message)")
            }
            self.contentTypeRepository.getMoviesOrSeries(type: type) {
                completion(.success($0))
                
            }
        }
    }
    
    func getDetail(id: Int, completion: @escaping (MDBResult<MovieObject>) -> Void) {
        networkAgent.getDetail(id: id) { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveDetail(id: id, movie: data)
            case .failure(let message):
                print("\(message)")
            }
            self.movieRepository.getDetail(id: id) { completion(.success($0)) }
        }
    }
    
    func getDetailOffline(id : Int, completion : @escaping (MDBResult<MovieObject>) -> Void){
        self.movieRepository.getDetail(id: id) { completion(.success($0))}
    }
    
}
