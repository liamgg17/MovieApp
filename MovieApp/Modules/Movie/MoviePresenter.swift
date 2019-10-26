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
    private var isLoading: Bool = false
    
    var movie: [MovieEntity] {
        guard let movies = self.interactor?.moviesSection?.movies else { return [] }
        
//        if self.searchMovieTitle.isEmpty {
//            return movies
//        } else {
//            return movies.filter({ $0.title?.lowercased().contains(self.searchMovieTitle) ?? false })
//        }
        
        return movies
    }
    
    private var currentPage: Int {
       // return self.interactor.moviesCategory?.page ?? 1
        return 1
    }
    
    var shouldFetchNextPageMovies: Bool {
        //   let totalPages: Int? = self.interactor.moviesCategory?.totalPages
        
        let totalPages: Int? = 1
        let isConnectedToInternet: Bool = NetworkError.isConnectedToInternet
        return !self.isLoading && self.currentPage != totalPages && !self.shouldSearchMovie && isConnectedToInternet
    }
    
    var shouldSearchMovie: Bool = false {
        didSet {
            guard !self.shouldSearchMovie else { return }
         //   self.searchMovieTitle = ""
        }
    }
    
    
 
    
    
    
}

extension MoviePresenter: MoviePresenterProtocol {
  
    
   
    // TODO: Implementación de los métodos del Presenter
    func viewDidLoad() {
        
        print("hola")
        interactor?.movieFetch()
        
    }
    

//    func fetchMovies(from section: MoviesSectionType) {
//        self.currentSection = section
//    }
    
    func reloadMovies() {
       // self.isLoading = true
       // self.interactor.fetchMovies(from: self.currentSection, atPage: 1)
    }
    
    func fetchNextPageMovies() {
       // self.isLoading = true
        //self.interactor.fetchMovies(from: self.currentSection, atPage: self.currentPage + 1)
    }
    
    func searchMovie(byTitle title: String) {
     //   self.searchMovieTitle = title.lowercased()
    }
    
    func didSelectMovie(_ movie: MovieEntity) {
      //  self.wireframe.presentDetails(from: movie)
    }
    
   
    
}

extension MoviePresenter: MovieInteractorOutputProtocol {
  
    
    func fetchMoviesDidSucceed() {
        
        self.isLoading = false
        
        if self.currentPage > 1 {
            self.view!.addNewMovies()
        } else {
            self.view!.reloadMovies()
            
        }
    }
    
    func fetchMoviesDidFailed(_ error: NetworkError) {
        self.isLoading = false
        
        if error.type == .networkError {
            self.view!.didFailedMovies(localizedError: error.localizedDescription)
        }
    }
    
    // TODO: implement interactor output methods
}
