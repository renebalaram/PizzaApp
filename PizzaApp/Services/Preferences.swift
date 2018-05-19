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
        static let sorting = "sorting"
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
    
    static var sortingType: Entity.Sorting {
        if let sortingType = UserDefaults.standard.value(forKey: Keys.sorting) as! Entity.Sorting.RawValue? {
            switch sortingType {
            case Entity.Sorting.byPopularity.rawValue:
                return Entity.Sorting.byPopularity
            case Entity.Sorting.byNameAsc.rawValue:
                return Entity.Sorting.byNameAsc
            case Entity.Sorting.byNameDesc.rawValue:
                return Entity.Sorting.byNameDesc
            default:
                return Entity.Sorting.byPopularity
            }
        }
        return Entity.Sorting.byPopularity
    }
    
    class func setPizzaSorting(as sortingType: Entity.Sorting) {
        UserDefaults.standard.set(sortingType.rawValue, forKey: Keys.sorting)
    }
    
}







