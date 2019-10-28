//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import UIKit


class MovieDetailView: UIViewController {
    
 

    // MARK: Properties
    var presenter: MovieDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    // TODO: implement view output methods
}
