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
    
    func viewDidLoad()
}

protocol MovieInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol MovieInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MovieInteractorOutputProtocol? { get set }
    var localDatamanager: MovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol? { get set }
    
    
    func movieFetch()
    
}

protocol MovieDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MovieRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol? { get set }

    func movieFetch(urlString:String)

}

protocol MovieRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol MovieLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
