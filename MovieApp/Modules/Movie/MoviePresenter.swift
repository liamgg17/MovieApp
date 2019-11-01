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
    
    // MARK: Propiedades
    
    
    weak var view: MovieViewProtocol?
    var interactor: MovieInteractorInputProtocol?
    var wireFrame: MovieWireFrameProtocol?
    
    private var isLoading: Bool = false
    
    
    /**
     Propiedad que se comunica con el protocolo MovieInteractorInputProtocol medinte el método
     moviesSection para obtener el listado de peliculas. En caso de que searchMovieTitle no este vacío se realiza el filtro por title
     
     :returns: Objeto de tipo MovieEntity
     */
    
    
    var movie: [MovieEntity] {
        guard let movies = self.interactor?.moviesSection?.movies else { return [] }
        
       if self.searchMovieTitle.isEmpty {
            return movies
        } else {
        
       return movies.filter({ $0.title?.lowercased().contains(self.searchMovieTitle) ?? false })
        }
    }
    
    
    /**
     Propiedad que verifica si el campo de búsqueda es vacio, en ee caso se comunica con el protocolo MovieViewProtocol mediante la función realoadMovies() para refrescar el CollectionView
     
    */
 
    
    private var searchMovieTitle: String = "" {
        didSet {
            self.view!.reloadMovies()
        }
    }
    
    
    /**
     Propiedad que se comunica con el protocolo MovieInteractorInputProtocol mediante el metodo geMovie para obtener las películas de una sección
     
     */
    
    
    private var currentSection: Section = .popular {
        
        didSet {
            self.isLoading = true
            self.interactor?.getMovie(section: self.currentSection, page: 1)
        }
    }
    
    /**
     Propiedad que se comunica con el protocolo MovieInteractorInputProtocol mediante el metodo movieSection para el numerto de página actual
      :returns: Entero que indica el número de página actual
     */
    
    private var currentPage: Int {
        return self.interactor?.moviesSection?.page ?? 1
        
    }
    
    /**
     Propiedad que sirve para determinar si se deería obtener la siguiente página de peliculas.
     
     :returns: Bool  True o false
     */
    
    var shouldGetNextPageMovies: Bool {
       
        let isConnectedToInternet: Bool = NetworkManager.isConnectedToInternet
        return !self.isLoading  && !self.shouldSearchMovie && isConnectedToInternet
    }
    
    /**
     Propiedad que sirve para deteminar si se debería realizar la búsqueda
     :returns: Bool  True o false
     */
    
    var shouldSearchMovie: Bool = false {
        didSet {
            guard !self.shouldSearchMovie else { return }
            self.searchMovieTitle = ""
        }
    }
    
   
}

extension MoviePresenter: MoviePresenterProtocol {
   
   
    var sectionTitle: String {
        
        switch self.currentSection {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    
    // MARK:  Implementación de los métodos del Presenter
    
    /**
     Implementación de función llamada desde el protcolo MovieViewProtocol para establecer la sección actual
     :param: section Enum del tipo Sección
     */
  
    
    func getMovies(from section: Section) {
        self.currentSection = section
    }
    
    
    /**
     Función  que es llamada desde el protcolo MovieViewProtocol que realiza el cambio de sección
     :param: sectionType Enum del tipo Sección
     */
    
   
    func changeSection(from sectionType: Section) {
        self.currentSection = sectionType
    }
    
    
    /**
     Función  que le comunica al protocolo MovieInteractorInputProtocol mediante el método getMovie para obtener las pelícuas de sección actual de la siguiente página
 
     */
    
    func getNextPage() {
      
        self.isLoading = true
         self.interactor?.getMovie(section: self.currentSection, page: self.currentPage + 1)
       
    }
    
   
    
    func searchMovie(title: String) {
        
        self.searchMovieTitle = title.lowercased()
    }
    
    /**
     Función  que le comunica al protocolo MovieInteractorInputProtocol para mostrar la vista detalle de una película
     
     */
    
    
    func selectMovie(_ movie: MovieEntity) {
        
        self.wireFrame?.presentMovieDetail(from:view!, movie: movie)
    }
    
    
   
    
   
    
}

extension MoviePresenter: MovieInteractorOutputProtocol {
  
    
     // MARK:  Implementación de los métodos del Interactor
    
    /**
     Función  que es llamada desde el  Interactor para añadir películas o recargar el CollectionView
  
     */
    
    
    func getMoviesDidSucceed() {
        
        self.isLoading = false
        
        if self.currentPage > 1  {
            self.view!.addMovies()
        } else {
            self.view!.reloadMovies()
            
        }
    }
    
    /**
     Función  que es llamada desde el Interactor para el error al obtener la lista de películas
     
     */
    
    func getMoviesDidFailed(_ error: NetworkManager) {
       
        self.isLoading = false
        
        if error.type == .networkError {
            self.view!.didFailedMovies(localizedError: error.localizedDescription)
        }
    }
    
 
}
