//
//  MovieView.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit


class MovieView: UIViewController {

    // MARK: Propiedades
    var presenter: MoviePresenterProtocol?
    
   
    // MARK: Outlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    
    // MARK: Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.initMoviesCollectionView()
        self.initSegmentedControl()
        self.initSearchControl()
        self.presenter!.getMovies(from: .popular)
        self.showLoader()
        
    }
    
    // MARK:  Inicialización de SegmentedControl
    
    private func initSegmentedControl() {
        
        let items = ["Popular" , "Top Rated", "Upcoming"]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.center = self.view.center
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.sectionChanged(_:)), for: .valueChanged)
        
        segmentedControl.layer.cornerRadius = 10.0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "AvenirNext-Medium", size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "AvenirNext-Medium", size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor
            ], for: .selected)
        
        self.navigationItem.titleView = segmentedControl
        
    }
    
    // MARK:  Inicialización de SearchControl
    
    func initSearchControl() {
        
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchBar.tintColor = UIColor.primaryColor
        search.obscuresBackgroundDuringPresentation = false
        search.definesPresentationContext = true
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
            self.navigationItem.hidesSearchBarWhenScrolling = true
        }
        
    }
    
    // MARK:  Inicialización de CollectionView
    
    
    private func initMoviesCollectionView() {
        
        // Configuración de la celda customizada
        
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        CollectionMovieCell.register(self.moviesCollectionView)
        
    }
    
    
    @objc func sectionChanged(_ control: UISegmentedControl) {
       
        guard let section = Section(rawValue: control.selectedSegmentIndex) else { return }
    
            self.moviesCollectionView.setContentOffset(.zero, animated: true)
            self.presenter!.getMovies(from: section)
            self.navigationItem.title = self.presenter?.sectionTitle
        
    }
    
 
   
}


// MARK: - UISearchBarDelegate


extension MovieView: UISearchBarDelegate {
    
    
    // MARK: - Métodos
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.presenter!.shouldSearchMovie = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter!.shouldSearchMovie = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
        searchBar.resignFirstResponder()
        self.presenter!.searchMovie(title: searchBar.text!)
    }
}



// MARK: - UICollectionViewDataSource


extension MovieView: UICollectionViewDataSource {
    
    // MARK: - Métodos
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return (self.presenter?.movie.count)!
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionMovieCell", for: indexPath) as? CollectionMovieCell else { return UICollectionViewCell() }
     
        cell.setValuesForFields(with: self.presenter!.movie[indexPath.item])
      
        return cell
    }
    

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieView: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Propiedades
    
    private var insetForSections: UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 0.0, bottom: 2.0, right: 0.0)
    }
    
    private var margin: CGFloat {
        return 0.0
    }
    
    // MARK: - Métodos
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.insetForSections
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.margin
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.margin
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = self.insetForSections.left + self.insetForSections.right + self.margin
        let width = (self.view.bounds.size.width - padding) / 3
        let ratio: CGFloat = 1.9
        let height = width * ratio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerSize = CGSize(width: self.view.frame.size.width, height: 40.0)
        return footerSize
    }
}

// MARK: - UICollectionViewDelegate

extension MovieView: UICollectionViewDelegate {
    
    // MARK: - Métodos
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        if lastRowIndex == indexPath.row {
        self.presenter!.getNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard self.presenter!.movie.indices.contains(indexPath.item) else { return }
       
        self.presenter!.selectMovie(self.presenter!.movie[indexPath.item])
        
    }
    
 
}

// MARK: - MovieViewProtocol

extension MovieView: MovieViewProtocol {
 
   
    /**
     Función para recargar el CollectionView y ocular el loader
     

     */
    
    func reloadMovies() {
       
        self.moviesCollectionView.reloadData()
        self.hideLoader()
    
    }
    
    /**
     Función para insertar los nuevos items de películas en el CollectionView
     
     */
    
    func addMovies() {
        
        var indexPaths: [IndexPath] = []
     
 
        if self.presenter!.movie.count > 20 {
            for _ in 0..<20{
                indexPaths.append(IndexPath(item: self.presenter!.movie.count - 20 + 1, section: 0))
                
                // MEJORAR
            }
        }
        
        
        self.moviesCollectionView.performBatchUpdates({
                        self.moviesCollectionView.insertItems(at: indexPaths)
                   })
    }
    
   
    
    func didFailedMovies(localizedError: String) {
        
        self.reloadMovies()

    }
    
    
}
