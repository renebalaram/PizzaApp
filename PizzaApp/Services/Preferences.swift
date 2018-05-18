//
//  Preferences.swift
//  PizzaApp
//
//  Created by mac on 5/9/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation

//enum Keys: String {
//    case pizzaCount = "pizzaCount"
//}

class Preferences {
    
    struct Keys {
        static let pizzaCount = "pizzaCount"
        static let favorite = "Favorite"
        static let theme = "theme"
    }

    // read pizza count from User Defaults
    // if no count is present, use the default (20)
    static var pizzaCount: Int {
        let count = UserDefaults.standard.value(forKey: Keys.pizzaCount)
        return (count as? Int) ?? 20
    }
    
    // update the pizza count by saving to user defaults
    class func setPizzaCount(to count: Int){
        UserDefaults.standard.set(count, forKey: Keys.pizzaCount)
    }
    
}
