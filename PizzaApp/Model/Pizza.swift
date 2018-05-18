//
//  Pizza.swift
//  PizzaApp
//
//  Created by mac on 5/8/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation

struct Pizza: Decodable {
    
    var toppings: [String]
    var price: Int?
}


extension Pizza: Equatable {
    
    static func ==(lhs: Pizza, rhs: Pizza) -> Bool {
        return lhs.toppings.sorted() == rhs.toppings.sorted()
    }
}

extension Pizza: Hashable {
    
    var hashValue: Int {
        return toppings.sorted().joined().hashValue
    }
}
