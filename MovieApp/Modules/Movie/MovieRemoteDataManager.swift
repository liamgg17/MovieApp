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
typealias FailureR = (_ error: NetworkManager) -> Void

class MovieRemoteDataManager:MovieRemoteDataManagerInputProtocol {
    
    
    /**
     Función  que se encarga de realizar el request al Servidor para obtener el listado de películas
     
     :params: urlString String que contiene el endpoint que obtiene el listado de las películas
     :returns: success Objeto JSON con la información obtenida
     
     */
    
    func getMovie(urlString: String, success: @escaping (JSON) -> Void) {
        
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
    
    
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol?
    
   
}
