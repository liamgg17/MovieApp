//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
 
    
    // MARK: Propiedades
    
    weak var presenter: MovieDetailInteractorOutputProtocol?
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
    var movie: MovieEntity
    
    
    
    init(movie: MovieEntity) {
        self.movie = movie
    }
    
    /**
     Esta función se comunica con el Protocolo MovieDetailRemoteDataManagerInputProtocol  para solitar los detalles de una película en particular. En caso de obtener respuesta satisfactoria se comunica con el Presenter medainte el método getMovieDetailsDidSucceed() 
     
     
     */
    
    
    func getMovieDetails() {
        
        guard let movieId = self.movie.id else {
            self.presenter!.getMovieDetailsDidFailed(.error(.internalError))
            return
        }
        
        let urlStr = "\(ApiSettings.ApiBaseUrl)/movie/\(movieId)?api_key=\(ApiSettings.apiKey)&append_to_response=videos"
        
    
        remoteDatamanager?.getMovieDetail(urlString: urlStr, success: { json in
            
            
            guard let movie = MovieEntity(JSON: json) else {
                 NetworkManager.error(.internalError)
                return
            }
            
            self.movie = movie
            self.presenter!.getMovieDetailsDidSucceed()
            
        })
        
        
    }
    

}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    
}
