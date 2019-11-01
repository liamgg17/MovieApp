//
//  MovieDetailWireFrame.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    
    /**
     
     Función que crea la instancia del modulo de VIPER
     
     :returns: VieController instanciado
     
     */

    class func createMovieDetailModule(movie: MovieEntity) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailView")
        if let view = viewController as? MovieDetailView {
            let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
            let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor(movie: movie)
            let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager()
            let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
    }
    
}
