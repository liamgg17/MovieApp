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
    
    
    /**
     
     Función que crea la instancia del modulo de VIPER
     
     :returns: VieController instanciado
     
     */

    class func createMovieModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MovieView")
        if let view = navController.children.first as? MovieView {
            let presenter: MoviePresenterProtocol & MovieInteractorOutputProtocol = MoviePresenter()
            let interactor: MovieInteractorInputProtocol & MovieRemoteDataManagerOutputProtocol = MovieInteractor()
            let remoteDataManager: MovieRemoteDataManagerInputProtocol = MovieRemoteDataManager()
            let wireFrame: MovieWireFrameProtocol = MovieWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Movie", bundle: Bundle.main)
    }
    
    /**
     
     Función para mostrar la vista detalle de una película llamando al método createMovieDetailModule del protocolo MovieDetailWireFrameProtocol
     
     :params: from  MovieViewProtocol Módulo de VIPER origen
     :params: movie Objeto de tipo MovieEntity
     */
    
    func presentMovieDetail(from: MovieViewProtocol, movie: MovieEntity) {
        
       let movieDetail = MovieDetailWireFrame.createMovieDetailModule(movie: movie)
       if let view = from as? UIViewController {
            view.navigationController?.pushViewController(movieDetail, animated: true)
        }
    }
   
  
}
