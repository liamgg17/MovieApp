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
typealias FailureR = (_ error: NetworkError) -> Void

class MovieRemoteDataManager:MovieRemoteDataManagerInputProtocol {
    func movieFetch(urlString: String, success: @escaping (JSON) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            let request =   Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            
         
            request.responseJSON(completionHandler: { dataResponse in
                
                
                switch dataResponse.result {
                case .success(let result):
                    
                    let json: JSON = result as? JSON ?? [:]
                     success(json)
                    
                case .failure(_): break
                    //case .failure(let error): break
                    
                    //FailureR(NetworkError)
                }
            })
        }
    }
    
    
    
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol?
    
    
    // Función para obtener las peliculas del servidor
    
   
   
    
    
    
}
