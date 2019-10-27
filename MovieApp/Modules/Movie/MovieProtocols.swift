//
//  MovieProtocols.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit

protocol MovieViewProtocol: class {
    // Presenter -> View
    var presenter: MoviePresenterProtocol? { get set }
    func reloadMovies()
    func addNewMovies()
    func didFailedMovies(localizedError: String)
    
    
}

protocol MovieWireFrameProtocol: class {
    // Presenter -> Wireframe
    static func createMovieModule() -> UIViewController
}

protocol MoviePresenterProtocol: class {
    // View -> Presenter
    var view: MovieViewProtocol? { get set }
    var interactor: MovieInteractorInputProtocol? { get set }
    var wireFrame: MovieWireFrameProtocol? { get set }
    var movie: [MovieEntity] { get }
    var shouldFetchNextPageMovies: Bool { get }
    var shouldSearchMovie: Bool { get set }
    var  sectionTitle: String { get }
    func changeSection(from section: Section)
    func fetchNextPage()
    func fetchMovies(from section: Section)
}

protocol MovieInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    
    func fetchMoviesDidSucceed()
    func fetchMoviesDidFailed(_ error: NetworkError)
    
    
}

protocol MovieInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MovieInteractorOutputProtocol? { get set }
    var localDatamanager: MovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol? { get set }
    
    var moviesSection: SectionEntity? { get }
    
   
    
     func movieFetch(section: Section, page: Int)
    
}

protocol MovieDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MovieRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol? { get set }

    func movieFetch(urlString:String, success: @escaping (JSON) -> Void)

}

protocol MovieRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol MovieLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
