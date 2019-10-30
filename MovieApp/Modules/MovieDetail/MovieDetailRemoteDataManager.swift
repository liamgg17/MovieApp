//
//  MovieDetailRemoteDataManager.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/27/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import Alamofire

class MovieDetailRemoteDataManager:MovieDetailRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?
    
    
    func getMovieDetail(urlString: String, success: @escaping (JSON) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            let request =   Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            
            
            request.responseJSON(completionHandler: { dataResponse in
                
                
                switch dataResponse.result {
                case .success(let result):
                    
                    let json: JSON = result as? JSON ?? [:]
                    success(json)
                    
                case .failure(_): break
                    
                }
            })
        }
    }
    
}
