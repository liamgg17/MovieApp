//
//  DateExtension.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/31/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

extension Date {
    
    
    
    var formattedString: String {
        
        var _signedDate:Date? = nil
        
        _signedDate = self
        guard _signedDate != nil else { return " " }
        
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
