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
    var joinedToppings: String {
        return toppings.joined(separator: ", ")
    }
    
    init(toppings: [String],price: Int?){
        self.toppings = toppings.sorted()
        self.price = price
    }
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
