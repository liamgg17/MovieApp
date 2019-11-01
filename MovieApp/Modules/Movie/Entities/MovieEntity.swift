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
    var releaseDate: Date?
    var posterPath: String?
    var backdropPathURL: String?
    var runtime : Int?
    var videos: [VideoEntity]?
    var genres: [String]?
    
    // MARK:  Métodos
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }

    
    // MARK: Mapeo del entity Movie
    
    
    func mapping(map: Map) {
        
        self.id <- map["id"]
        self.title <- map["title"]
        self.overview <- map["overview"]
        self.budget <- map["budget"]
        self.revenue <- map["revenue"]
        self.posterPath <- map["poster_path"]
        self.backdropPathURL <- map["backdrop_path"]
        self.videos <- map["videos.results"]
        self.voteAverage <- map["vote_average"]
        self.popularity <- map["popularity"]
        self.runtime <- map["runtime"]
        
        
        if let genresJSON = map.JSON["genres"] as? [JSON] {
            self.genres = genresJSON.compactMap({ $0["name"] as? String })
        }
        if let releaseDateString = map.JSON["release_date"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = .current
            self.releaseDate = formatter.date(from: releaseDateString)
        }
  
    }
    
    
}
