//
//  UIViewControllerExtension.swift
//  MovieApp
//
//  Created by Christian Martinez on 10/28/19.
//  Copyright © 2019 Christian Martinez. All rights reserved.
//


import NVActivityIndicatorView

class UIViewControllerExtension: UIViewController {
    
    
    // MARK: - Internal Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return self.statusBarStyle }
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            guard self.statusBarStyle != oldValue else { return }
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    

}


extension UIViewController {
    
    
    
    
    
    func showLoader(optSize: CGSize? = nil, optType: NVActivityIndicatorType? = nil, optColor: UIColor? = nil){
        let actData = ActivityData(
            size: (optSize ?? CGSize(width: 80, height: 80)),
            message: nil,
            messageFont: nil,
            messageSpacing: nil,
            type: (optType ?? .circleStrokeSpin),
            color: (optColor ?? UIColor.primaryColor),
            padding: nil,
            displayTimeThreshold: nil,
            minimumDisplayTime: nil,
            backgroundColor: UIColor.black.withAlphaComponent(0.50),
            textColor: nil
        )
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(actData, nil)
    }
    
    func hideLoader(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
}

extension UIViewControllerExtension: UINavigationBarDelegate {
    
    // MARK: - Internal Methods
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}



