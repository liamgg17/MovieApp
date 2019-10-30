//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit
import YoutubePlayer_in_WKWebView

class MovieDetailView: UIViewControllerExtension {
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var playerView: WKYTPlayerView!
  
    // MARK: Propiedades
    
    var presenter: MovieDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
        self.presenter!.viewDidLoad()
        
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    private func setData() {
        
          // 
        
        
            self.scrollView.delegate = self
            self.gradientView.fadeView(style: .top, percentage: 0.9)
        
            if let backdropImagePath = self.presenter!.movie.backdropPathURL {
            let urlString = ApiSettings.getImage(fromPath: backdropImagePath)
            self.blurImageView.downloadImage(fromURLString: urlString)
            
        
            let backView = UIView(frame: self.blurImageView.bounds)
            backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.blurImageView.addSubview(backView)
            

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.blurImageView.bounds
            self.blurImageView.addSubview(blurEffectView)
            
           }
        
            if let posterImagePath = self.presenter!.movie.posterPath {
            let urlString = ApiSettings.getImage(fromPath: posterImagePath)
            self.posterImageView.downloadImage(fromURLString: urlString)
              
            
                self.posterImageView.clipsToBounds = false
                self.posterImageView.layer.shadowColor = UIColor.black.cgColor
                self.posterImageView.layer.shadowOpacity = 1
                self.posterImageView.layer.shadowOffset = CGSize.zero
                self.posterImageView.layer.shadowRadius = 10
                self.posterImageView.layer.shadowPath = UIBezierPath(roundedRect:  self.posterImageView.bounds,  cornerRadius: 0).cgPath
           }
        
            self.titleLabel.text = self.presenter!.movie.title
            self.subtitleLabel.text = self.presenter!.movie.releaseDate
        
            let overview = self.presenter!.movie.overview ?? ""
            self.overviewLabel.text = !overview.isEmpty ? overview : ""
  
            let average = self.presenter!.movie.voteAverage ?? 0
        
        
            let averageRate = NSMutableAttributedString()
            averageRate
            .bold(String (average))
            .normal(" / 10")
        
            self.rateLabel.attributedText = averageRate
        
        
            let popularity = self.presenter!.movie.popularity ?? 0
            self.popularity.text = String (popularity)
        
        
      
    }
    
}



extension MovieDetailView: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if scrollView.contentOffset.y <= 0 {
           
           self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController!.navigationBar.shadowImage = UIImage()
            self.navigationController!.navigationBar.isTranslucent = true
            
        } else {
           
            self.navigationController!.navigationBar.setBackgroundImage(nil, for: .default)
         
        }
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    // TODO: implement view output methods
    
    func updateMovieDetails() {
        
       
        self.view.layoutIfNeeded()
        
        let duration = self.presenter!.movie.runtime ?? 0
        self.durationLabel.text = "Duration: " + String (duration) + "min"
      
        
        let budget = self.presenter!.movie.budget?.convertDoubleToCurrency  ?? " "
        self.budgetLabel.text = "Budget: " + budget
       
        
        let revenue = self.presenter!.movie.revenue!.convertDoubleToCurrency  ?? " "
        self.revenueLabel.text = "Revenue: " + revenue
       

      }
    
    func  playVideo(key: String) {
        
         playerView.load(withVideoId: key)
        
    }
    
    
    
}
