//
//  CollectionMovieCell.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/25/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import UIKit

class CollectionMovieCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        self.title.text = nil
        self.imageView.image = nil
        self.imageView.stopDownloadImage()
    }
    
    override func prepareForReuse() {
        super.awakeFromNib()
      
    }
    
    func setValuesForFields(with movie: MovieEntity) {
        
        self.title.text = movie.title
        self.category.text =  movie.releaseDate
        self.category.textColor = UIColor.primaryColor
        
        if let movieImagePath = movie.posterPath  {
            
            let urlString = ApiSettings.getImage(fromPath: movieImagePath)
            self.imageView.downloadImage(fromURLString: urlString) 
        }
    }
    
    
    static func register(_ collectionView: UICollectionView) {
        let reuseIdentifier = String(describing: self.self)
        let nib = UINib(nibName: reuseIdentifier, bundle: Bundle(for: self.self))
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

}
