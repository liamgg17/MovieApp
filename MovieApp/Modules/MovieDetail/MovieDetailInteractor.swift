//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
 
    
    // MARK: Properties
    weak var presenter: MovieDetailInteractorOutputProtocol?
    var localDatamanager: MovieDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
    var movie: MovieEntity
    
    init(movie: MovieEntity) {
        self.movie = movie
    }
    
    func getMovieDetails() {
        
        guard let movieId = self.movie.id else {
            self.presenter!.getMovieDetailsDidFailed(.error(.internalError))
            return
        }
        
        let urlStr = "\(ApiSettings.ApiBaseUrl)/movie/\(movieId)?api_key=\(ApiSettings.apiKey)&append_to_response=videos,credits"
        
    
        remoteDatamanager?.getMovieDetail(urlString: urlStr, success: { json in
            
            
            guard let movie = MovieEntity(JSON: json) else {
                 NetworkError.error(.internalError)
                return
            }
            
            self.movie = movie
            self.presenter!.getMovieDetailsDidSucceed()
            
             
        })
        
        
    }
    

}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
