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

}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
