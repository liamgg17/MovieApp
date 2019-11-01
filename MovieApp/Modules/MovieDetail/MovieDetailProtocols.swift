//
//  MovieDetailProtocols.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailViewProtocol: class {
    
    // PRESENTER -> VIEW
    
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func updateMovieDetails()
    func playVideo(key: String)
}

protocol MovieDetailWireFrameProtocol: class {
   
    // PRESENTER -> WIREFRAME
    
    static func createMovieDetailModule(movie: MovieEntity) -> UIViewController
}

protocol MovieDetailPresenterProtocol: class {
    
    // VIEW -> PRESENTER
   
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var wireFrame: MovieDetailWireFrameProtocol? { get set }
    var movie: MovieEntity { get }
    
    func viewDidLoad()
    
    
}

protocol MovieDetailInteractorOutputProtocol: class {

    // INTERACTOR -> PRESENTER
    
    func getMovieDetailsDidSucceed()
    func getMovieDetailsDidFailed(_ error: NetworkManager)
}

protocol MovieDetailInteractorInputProtocol: class {
    
    // PRESENTER -> INTERACTOR
    
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }
    var movie: MovieEntity { get }
    
    func getMovieDetails()

}

protocol MovieDetailDataManagerInputProtocol: class {
    
    // INTERACTOR -> DATAMANAGER
    
    
}

protocol MovieDetailRemoteDataManagerInputProtocol: class {
   
    // INTERACTOR -> REMOTEDATAMANAGER
    
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    func getMovieDetail(urlString:String, success: @escaping (JSON) -> Void)
}

protocol MovieDetailRemoteDataManagerOutputProtocol: class {
   
    // REMOTEDATAMANAGER -> INTERACTOR
}


