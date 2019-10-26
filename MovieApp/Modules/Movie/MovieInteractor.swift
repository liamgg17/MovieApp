//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import ObjectMapper


enum SectionType: Int {
    case popular
    case topRated
    case upcoming
}


class MovieInteractor: MovieInteractorInputProtocol {
   
    
    var moviesSection: SectionEntity?
    
  
    // MARK: Propiedades
    
    weak var presenter: MovieInteractorOutputProtocol?
    var localDatamanager: MovieLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol?
    
    
    private var isLoading: Bool = false
    
    
  
    func movieFetch() {

     let urlStr = "\(ApiSettings.ApiBaseUrl)/movie/popular?api_key=\(ApiSettings.apiKey)&page=1"
        
        remoteDatamanager?.movieFetch(urlString: urlStr, success: { json in
            
            guard let moviesSection = SectionEntity(JSON: json) else {
                NetworkError.error(.internalError)
                return
            }
            
            guard let page = moviesSection.page,
                let movies = moviesSection.movies else {
                    self.presenter!.fetchMoviesDidFailed(.error(.internalError))
                    return
            }
            
            if page > 1 {
                
                var currentMovies: [MovieEntity] = moviesSection.movies ?? []
                currentMovies.append(contentsOf: movies)
                self.moviesSection = moviesSection
                self.moviesSection!.movies = currentMovies
            } else {
                self.moviesSection = moviesSection
            }
            
            self.presenter?.fetchMoviesDidSucceed()
            
        })
        
      
    }
    
    
    
}



extension MovieInteractor: MovieRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    
    
    
    
}
