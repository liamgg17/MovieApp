//
//  DoubleExtension.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/29/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import Foundation

extension Double {
    
    var convertDoubleToCurrency: String?{
    
     guard self != 0 else { return "" }
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = Locale.current
    return numberFormatter.string(from: NSNumber(value: self))!
    }
    
}
