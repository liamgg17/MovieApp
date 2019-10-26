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

    // MARK: Properties
    var presenter: MoviePresenterProtocol?
    
    // MARK: Outlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        self.setupMoviesCollectionView()
        
    }
    
    private func setupMoviesCollectionView() {
        
        // Configuración de la celda customizada
        
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        
        CollectionMovieCell.register(self.moviesCollectionView)
//        LoadingCollectionReusableView.registerOn(self.collectionView,
//                                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        
        
    }
    
    
    
    
}


// MARK: - UICollectionViewDataSource

extension MovieView: UICollectionViewDataSource {
    
    // MARK: - Internal Methods
    
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
    
//    func collectionView(_ collectionView: UICollectionView,
//                        viewForSupplementaryElementOfKind kind: String,
//                        at indexPath: IndexPath) -> UICollectionReusableView {
//       guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingCollectionReusableView.reuseIdentifier, for: indexPath) as? LoadingCollectionReusableView, kind == UICollectionView.elementKindSectionFooter else { return UICollectionReusableView() }
//        return footerView
//    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieView: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Private Properties
    
    private var insetForSections: UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 0.0, bottom: 2.0, right: 0.0)
    }
    
    private var margins: CGFloat {
        return 0.0
    }
    
    // MARK: - Internal Methods
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.insetForSections
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.margins
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.margins
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = self.insetForSections.left + self.insetForSections.right + self.margins
        let width = (self.view.bounds.size.width - padding) / 3
        let ratio: CGFloat = 1.9
        let height = width * ratio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerSize = CGSize(width: self.view.frame.size.width, height: 20.0)
        return !self.presenter!.shouldFetchNextPageMovies ? .zero : footerSize
    }
}

// MARK: - UICollectionViewDelegate

extension MovieView: UICollectionViewDelegate {
    
    // MARK: - Internal Methods
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        
        
        let lastRowIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if lastRowIndex == indexPath.row && self.presenter!.shouldFetchNextPageMovies {
            self.presenter!.fetchNextPageMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            guard self.presenter!.movie.indices.contains(indexPath.item) else { return }
         //   self.presenter.didSelectMovie(self.presenter.movies[indexPath.item])
        
    }
    
  
    
   
}


extension MovieView: MovieViewProtocol {
 
   
    
    func reloadMovies() {
       
        self.moviesCollectionView.reloadData()
        //self.view.hideActivityIndicator()
       // self.refreshControl.endRefreshing()
    }
    
    func addNewMovies() {
        
        var indexPaths: [IndexPath] = []
        
        for (index, movie) in self.presenter!.movie.enumerated()  {
            indexPaths.append(IndexPath(item: index, section: 0))
        }
        
        self.moviesCollectionView.performBatchUpdates({
            self.moviesCollectionView.insertItems(at: indexPaths)
        })
    }
    
    func didFailedMovies(localizedError: String) {
        
     //   let okAction = UIAlertAction(title: MessagesUtil.General.ok, style: .default)
//        self.showAlert(withTitle: MessagesUtil.General.oops,
//                       message: localizedError,
//                       actions: [okAction]) {
//                        self.reloadMovies()
//        }
    }
    
    // TODO: implement view output methods
}
