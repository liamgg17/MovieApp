//
//  ApiSettings.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

struct ApiSettings {
    
      // MARK: Proiedades
    
    static let ApiBaseUrl: String = "https://api.themoviedb.org/3"
    static let apiKey: String = "1d079f5ea0422f9924048bb364ca89ab"
    
    
    static func getImage(fromPath path: String) -> String {
        return "https://image.tmdb.org/t/p/w500/\(path)"
    }
   
}


