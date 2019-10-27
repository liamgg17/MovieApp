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
  
    
    

  
    // MARK: Propiedades VIPER
    

    weak var presenter: MovieInteractorOutputProtocol?
    var localDatamanager: MovieLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol?
    
    
    private(set) var moviesSection: SectionEntity?
    
    private var isLoading: Bool = false
    
    
    
    func movieFetch(section: Section, page: Int) {
    
        let urlStr = "\(ApiSettings.ApiBaseUrl)/movie/\(section)?api_key=\(ApiSettings.apiKey)&page=\(page)"
        
        print (urlStr)
        remoteDatamanager?.movieFetch(urlString: urlStr, success: { json in
            
            guard let movieSection = SectionEntity(JSON: json) else {
                NetworkError.error(.internalError)
                return
            }
            
            guard let page = movieSection.page,
                let movies = movieSection.movies else {
                    self.presenter!.fetchMoviesDidFailed(.error(.internalError))
                    return
            }
            
            if page > 1 {
                
                var currentMovies: [MovieEntity] = self.moviesSection!.movies ?? []
                currentMovies.append(contentsOf: movies)
                self.moviesSection = movieSection
                self.moviesSection?.movies = currentMovies
            } else {
                self.moviesSection = movieSection
            }
            
            self.presenter?.fetchMoviesDidSucceed()
            
        })
        
        
    }
  
 
    
    
    
}



extension MovieInteractor: MovieRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    
    
    
    
}
