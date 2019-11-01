//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

class MovieDetailPresenter  {
    
    // MARK: Propiedades
    
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var wireFrame: MovieDetailWireFrameProtocol?
   
    
    var movie: MovieEntity {
        return self.interactor!.movie
    }
    
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
   
    
    // MARK:  Implementación de los métodos del Presenter
    
    /**
     Función que se comunica con el MovieDetailInteractorInputProtocol mediante el método getMovieDetails() para obtener los detalles de una película en paticular
     
     
     */
    
    
    func viewDidLoad() {
       
        self.interactor!.getMovieDetails()
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    
    // MARK:  Implementación de los métodos del Interactor
    
    /**
    
     Función que se comunica con MovieDetailViewProtocol mediante el método updateMovieDetails() para actualizar la UI con los detalles de la película seleccionada
     
     
     */
    
    
    func getMovieDetailsDidSucceed() {
        self.view!.updateMovieDetails()
        
        guard let videos = self.movie.videos,
         
            let video = videos.first,
            let videoKey = video.key else { return }
            self.view!.playVideo(key: videoKey)
        
    }
    
    
    /**
     
     Función que se comunica con MovieDetailViewProtocol mediante el método updateMovieDetails() para actualizar la UI con los detalles de la película seleccionada
    
     */
    
    func getMovieDetailsDidFailed(_ error: NetworkManager) {
        
        self.view!.updateMovieDetails()
        
        guard let videos = self.movie.videos,
            let video = videos.first,
            let videoKey = video.key else { return }
            self.view!.playVideo(key: videoKey)
    }
    
   
}
