//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import ObjectMapper
class MovieInteractor: MovieInteractorInputProtocol {

    // MARK: Propiedades
    
    weak var presenter: MovieInteractorOutputProtocol?
    var localDatamanager: MovieLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol?
    private(set) var movies: MovieEntity?
    
    func movieFetch() {

        // remoteDatamanager?.movieFetch()
        
        
        let urlStr = "\(ApiSettings.ApiBaseUrl)/movie/popular?api_key=\(ApiSettings.apiKey)&page=1"
        
        remoteDatamanager!.movieFetch(urlString: urlStr)
        
    }
}
extension MovieInteractor: MovieRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
