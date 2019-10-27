//
//  UIImageViewExtension.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/25/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Image Manager

extension UIImageView {
    

    func downloadImage(fromURLString urlString: String, completion: (() -> Void)? = nil) {
        
        self.kf.setImage(with: URL(string: urlString),
                         options: [.transition(.fade(0.3))]) { _ in
                            completion?()
        }
    }
    
  
    func stopDownloadImage() {
        self.kf.cancelDownloadTask()
    }
}
