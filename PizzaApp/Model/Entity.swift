//
//  Entity.swift
//  PizzaApp
//
//  Created by mac on 5/11/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation


struct Entity {
    
    struct Keys {
        enum Pizza: String {
            case favorite = "favorite"
            case date = "orderDate"
            case toppings = "toppings"
        }
        
    }
    
    enum Names: String {
        case pizza = "PizzaOrder"
        case topping = "Topping"
    }
    enum Sorting: String {
        case byNameAsc = "SorByNameAscending"
        case byNameDesc = "SortByNameDescending"
        case byPopularity = "SortByPopularity"
    }
}
