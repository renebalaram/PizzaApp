//
//  Order.swift
//  PizzaApp
//
//  Created by mac on 5/11/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation
import CoreData

struct Order {
    
    let toppings: [String]
    let date: Date
    var favorite: Bool
    
    var toppingString: String {
        return toppings.joined(separator: ", ")
    }
    
    init?(entity: NSManagedObject){
        guard
            let date = entity.value(forKey: Entity.Keys.Pizza.date.rawValue) as? Date,
            let favorite = entity.value(forKey: Entity.Keys.Pizza.favorite.rawValue) as? Bool,
            let toppings = entity.value(forKey: Entity.Keys.Pizza.toppings.rawValue) as? [String]
            else {
                return nil
        }
        
        self.date = date
        self.favorite = favorite
        self.toppings = toppings
        
    }
}
