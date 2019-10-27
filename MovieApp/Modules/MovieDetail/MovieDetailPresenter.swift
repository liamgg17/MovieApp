//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

class MovieDetailPresenter  {
    
    // MARK: Properties
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var wireFrame: MovieDetailWireFrameProtocol?
    
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
