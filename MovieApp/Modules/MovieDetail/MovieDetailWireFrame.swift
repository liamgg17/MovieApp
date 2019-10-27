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

    class func createMovieDetailModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailView")
        if let view = navController.children.first as? MovieDetailView {
            let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
            let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor()
            let localDataManager: MovieDetailLocalDataManagerInputProtocol = MovieDetailLocalDataManager()
            let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager()
            let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
            
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
        return UIStoryboard(name: "MovieDetailView", bundle: Bundle.main)
    }
    
}
