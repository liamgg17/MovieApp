//
//  NetworkError.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/24/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError {
    
    // MARK: - Definitions
    struct Error {
        static let networkError: String = "Problema en la conexión a Internet. Inténtalo de nuevo."
        static let internalError: String = "Ups, ha ocurrido un error. Inténtalo de nuevo"
    }
    
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    enum LocalizedError: String {
        case networkError
        case internalError
        
        var description: String {
            switch self {
            case .networkError:
                return Error.networkError
            case .internalError:
                return Error.internalError
            }
        }
    }
    
    case error(NetworkError.LocalizedError)
    
    // MARK: - Propiedades
    
    var localizedDescription: String {
        switch self {
        case .error(let error):
            return error.description
        }
    }
    
    var type: LocalizedError {
        switch self {
        case .error(let errorType):
            return errorType
        }
    }
    
    // MARK: - Init
    
    init(_ error: Error?) {
        
        guard let errorCode = error,
            NetworkError.isConnectedToInternet else {
                self = .error(.networkError)
                return
        }
        
        switch errorCode {
        default:
            self = .error(.internalError)
        }
    }
}
