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
   
    var movie: MovieEntity {
        return self.interactor!.movie
    }
    
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
   
    
  
    // TODO: implement presenter methods
    func viewDidLoad() {
        
        self.interactor!.getMovieDetails()
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func getMovieDetailsDidSucceed() {
        self.view!.updateMovieDetails()
        
        guard let videos = self.movie.videos,
            let video = videos.first,
            let videoKey = video.key else { return }
            self.view!.playVideo(key: videoKey)
        
    }
    
    func getMovieDetailsDidFailed(_ error: NetworkError) {
        self.view!.updateMovieDetails()
        
        guard let videos = self.movie.videos,
            let video = videos.first,
            let videoKey = video.key else { return }
            self.view!.playVideo(key: videoKey)
    }
    
    // TODO: implement interactor output methods
}
