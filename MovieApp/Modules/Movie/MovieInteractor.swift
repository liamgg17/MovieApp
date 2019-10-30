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
    
    
    
    func getMovie(section: Section, page: Int) {
        
        var sectionString: String = ""
        
        switch section {
        case .popular:
            sectionString = "popular"
        case .topRated:
            sectionString = "top_rated"
        case .upcoming:
            sectionString = "upcoming"
        }
    
        let urlStr = "\(ApiSettings.ApiBaseUrl)/movie/\(sectionString)?api_key=\(ApiSettings.apiKey)&page=\(page)"
        
        print (urlStr)
        remoteDatamanager?.getMovie(urlString: urlStr, success: { json in
            
            guard let movieSection = SectionEntity(JSON: json) else {
                NetworkError.error(.internalError)
                return
            }
            
            guard let page = movieSection.page,
                let movies = movieSection.movies else {
                    self.presenter!.getMoviesDidFailed(.error(.internalError))
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
            
            self.presenter?.getMoviesDidSucceed()
            
        })
        
        
    }
  
}



extension MovieInteractor: MovieRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    
    
    
    
}
