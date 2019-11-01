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
    func addMovies()
    func didFailedMovies(localizedError: String)
    
    
}

protocol MovieWireFrameProtocol: class {
    
    // Presenter -> Wireframe
    
    static func createMovieModule() -> UIViewController
    func presentMovieDetail(from: MovieViewProtocol, movie: MovieEntity)
    
    
}

protocol MoviePresenterProtocol: class {
  
    // View -> Presenter
    
    var view: MovieViewProtocol? { get set }
    var interactor: MovieInteractorInputProtocol? { get set }
    var wireFrame: MovieWireFrameProtocol? { get set }
    var movie: [MovieEntity] { get }
    var shouldGetNextPageMovies: Bool { get }
    var shouldSearchMovie: Bool { get set }
    var sectionTitle: String { get }
    
    func selectMovie(_ movie: MovieEntity)
    func changeSection(from section: Section)
    func getNextPage()
    func getMovies(from section: Section)
    func searchMovie(title: String)
    
}

protocol MovieInteractorOutputProtocol: class {
  
    // INTERACTOR -> PRESENTER
    
    func getMoviesDidSucceed()
    func getMoviesDidFailed(_ error: NetworkManager)
    
    
}

protocol MovieInteractorInputProtocol: class {
   
    // PRESENTER -> INTERACTOR
    
    var presenter: MovieInteractorOutputProtocol? { get set }
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol? { get set }
    var moviesSection: SectionEntity? { get }
    
    func getMovie(section: Section, page: Int)

    
}

protocol MovieDataManagerInputProtocol: class {
  
    // INTERACTOR -> DATAMANAGER
}

protocol MovieRemoteDataManagerInputProtocol: class {
  
    // INTERACTOR -> REMOTEDATAMANAGER
  
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol? { get set }
  
    func getMovie(urlString:String, success: @escaping (JSON) -> Void)

}

protocol MovieRemoteDataManagerOutputProtocol: class {
   
    // REMOTEDATAMANAGER -> INTERACTOR
}


