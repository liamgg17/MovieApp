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
}

extension MovieDetailView: MovieDetailViewProtocol {
    // TODO: implement view output methods
}
