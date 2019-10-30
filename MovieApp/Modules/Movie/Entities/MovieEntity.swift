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
    var voteAverage : Double?
    var popularity : Double?
    var revenue: Double?
    var releaseDate: String?
    var posterPath: String?
    var backdropPathURL: String?
    var runtime : Int?
    var videos: [VideoEntity]?
    
    
    // MARK:  Métodos
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }

    
    // Mapeo del objeto Movie
    
    
    func mapping(map: Map) {
        
        self.id <- map["id"]
        self.title <- map["title"]
        self.overview <- map["overview"]
        self.budget <- map["budget"]
        self.revenue <- map["revenue"]
        self.releaseDate <- map["release_date"]
        self.posterPath <- map["poster_path"]
        self.backdropPathURL <- map["backdrop_path"]
        self.videos <- map["videos.results"]
        self.voteAverage <- map["vote_average"]
        self.popularity <- map["popularity"]
        self.runtime <- map["runtime"]
        
  
    }
    
    
}
