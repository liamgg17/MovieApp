//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

enum Section: Int {
   
    case popular
    case topRated
    case upcoming
}


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
    
    private var currentSection: Section = .popular {
        
        didSet {
            self.isLoading = true
            self.interactor?.movieFetch(section: .popular, page: 1)
        }
    }
    
    private var currentPage: Int {
        return self.interactor?.moviesSection?.page ?? 1
        
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
  
    
    func fetchMovies(from section: Section) {
        self.currentSection = section
    }

    func changeSection(from sectionType: Section) {
        self.currentSection = sectionType
    }
  
    func reloadMovies() {
       // self.isLoading = true
       // self.interactor.fetchMovies(from: self.currentSection, atPage: 1)
    }
    
    func fetchNextPage() {
      
        self.isLoading = true
        self.interactor?.movieFetch(section: self.currentSection, page: self.currentPage + 1)
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
