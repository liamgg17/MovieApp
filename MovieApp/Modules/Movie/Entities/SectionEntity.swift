//
//  SectionEntity.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/25/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import ObjectMapper

class SectionEntity: NSObject, Mappable {
    
    
    
    // MARK:  Propiedades
    
    var page: Int?
    var totalPages: Int?
    var Results: Int?
    var movies: [MovieEntity]?
    
   
    // MARK:  Métodos
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }

    
    
    // Mapeo del objeto Sección
    
    
    func mapping(map: Map) {
        self.page <- map["page"]
        self.totalPages <- map["total_pages"]
        self.Results <- map["total_results"]
        self.movies <- map["results"]
    }
    
}
