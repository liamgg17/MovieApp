//
//  VideoEntitiy.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/29/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoEntity: NSObject, Mappable {
    

    // MARK: - Propiedades
    
    var id: String?
    var key: String?
    var name: String?
   
    
    // MARK: - Métodos
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: - Mapeo del objeto Movie
    
     func mapping(map: Map) {
        self.id <- map["id"]
        self.key <- map["key"]
        self.name <- map["name"]
   
    }
}
