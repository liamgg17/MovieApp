//
//  MovieRemoteDataManager.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]

class MovieRemoteDataManager:MovieRemoteDataManagerInputProtocol {
  
    
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol?
    
    // Función para obtener las peliculas del servidor
    
   
    
    func movieFetch(urlString: String) {
        
    
            DispatchQueue.global(qos: .background).async {
          
                let request =   Alamofire.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)

            
            request.responseJSON(completionHandler: { dataResponse in
                
                
                switch dataResponse.result {
                case .success(let result):
                    
                    let json: JSON = result as? JSON ?? [:]
                    
                    print("JSON: \(json)")
                    
                   // success(json)
                case .failure(let error): break
                   
              //  failure(NetworkError((error as! NetworkError.Error)))
                }
            })
        }
    }
    
    
    
}
