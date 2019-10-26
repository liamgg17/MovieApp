//
//  MovieEntity.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieEntity:  NSObject, Mappable {
    
    
    
    // MARK:  Propiedades
    
    var id: Int?
    var title: String?
    var overview: String?
    var budget: Double?
    var revenue: Double?
    var releaseDate: Date?
    var genres: [String]?
    var posterPath: String?
    
    // MARK:  Métodos
    
    required init?(map: Map) {}
    
    // Mapeo del objeto Movie
    
    
    func mapping(map: Map) {
        
        self.id <- map["id"]
        self.title <- map["title"]
        self.overview <- map["overview"]
        self.budget <- map["budget"]
        self.revenue <- map["revenue"]
        self.releaseDate <- map["release_date"]
//       if let genres = map.JSON["genres"] as? String: Any { self.genres = genres.compactMap({ $0["name"] as? String })
//        }
        self.posterPath <- map["poster_path"]
        
  
    }
    
    
}
