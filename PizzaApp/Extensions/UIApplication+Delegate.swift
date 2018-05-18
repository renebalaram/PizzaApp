//
//  UIApplication+Delegate.swift
//  PizzaApp
//
//  Created by mac on 5/11/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var appDelegate: AppDelegate = {
        if Thread.isMainThread {
            return shared.delegate as! AppDelegate
        } else {
            var delegate: AppDelegate!
            DispatchQueue.main.sync {
                delegate = shared.delegate as! AppDelegate
            }
            return delegate
        }
    }()
}

