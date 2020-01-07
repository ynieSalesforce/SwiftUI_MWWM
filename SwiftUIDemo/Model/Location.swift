//
//  Location.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/6/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation

struct Location: Equatable, Hashable, Identifiable {
    var id: String
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    let coordinate: Coordinate
    let zipcode: String
}
