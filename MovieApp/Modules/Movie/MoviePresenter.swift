//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

class MoviePresenter  {
    
    // MARK: Properties
    weak var view: MovieViewProtocol?
    var interactor: MovieInteractorInputProtocol?
    var wireFrame: MovieWireFrameProtocol?
    
}

extension MoviePresenter: MoviePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        
        print("hola")
        interactor?.movieFetch()
        
    }
}

extension MoviePresenter: MovieInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
