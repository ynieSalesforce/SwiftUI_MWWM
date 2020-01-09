//
//  LocationMock.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation

extension Location {
    static func mock (
        id: String = "",
        name: String = "",
        coordinates: Coordinate = .createMock(lon: 34.56426, lat: -79.3342),
        zipcode: String
        
    ) -> Location{
        Location.init(id: id, name: name, coordinate: coordinates, zipcode: zipcode)
    }
}
