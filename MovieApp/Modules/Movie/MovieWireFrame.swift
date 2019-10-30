//
//  MovieWireFrame.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit


class MovieWireFrame: MovieWireFrameProtocol {
   
    
    private(set) weak var view: MovieView!

    class func createMovieModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MovieView")
        if let view = navController.children.first as? MovieView {
            let presenter: MoviePresenterProtocol & MovieInteractorOutputProtocol = MoviePresenter()
            let interactor: MovieInteractorInputProtocol & MovieRemoteDataManagerOutputProtocol = MovieInteractor()
            let localDataManager: MovieLocalDataManagerInputProtocol = MovieLocalDataManager()
            let remoteDataManager: MovieRemoteDataManagerInputProtocol = MovieRemoteDataManager()
            let wireFrame: MovieWireFrameProtocol = MovieWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Movie", bundle: Bundle.main)
    }
    
    func presentMovieDetail(from: MovieViewProtocol, movie: MovieEntity) {
        
        // Se crea e instancia el módulo de detalle
        
        let movieDetail = MovieDetailWireFrame.createMovieDetailModule(movie: movie)
        
        
        if let view = from as? UIViewController {
            
  
            view.navigationController?.pushViewController(movieDetail, animated: true)
        }
    }
   
  
}
