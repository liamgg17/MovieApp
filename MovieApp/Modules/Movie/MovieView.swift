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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieView: MovieViewProtocol {
    // TODO: implement view output methods
}
