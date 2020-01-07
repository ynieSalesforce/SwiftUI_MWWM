//
//  LocationProvider.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/6/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import SwiftUI

class LocationStore: ObservableObject {
    static var defaultValue: [Location] = []
    
    @Published var store: [Location] = [Location(id:"asdfzxcv" ,name: "Washington DC", coordinate: Coordinate(lon: 38.9072, lat: -77.0369), zipcode: "20001")]
    
    static var shared = LocationStore()
    
    public func addLocation(_ location: Location) {
        store.append(location)
    }
    
    public func removeLocation(_ location: Location) {
        store.removeAll { reference -> Bool in
            return reference == location
        }
    }
}

