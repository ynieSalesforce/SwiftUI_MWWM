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
    
    @Published var store: [Location] = [
        Location(id:"asdfzxcv" ,name: "Washington DC", coordinate: Coordinate(lon: 38.9072, lat: -77.0369), zipcode: "20001"),
        Location(id:"asdf678k" ,name: "Los Angeles", coordinate: Coordinate(lon: 34.0522, lat: -118.2437), zipcode: "91608"),
        Location(id:"avdfasdf" ,name: "Chicago", coordinate: Coordinate(lon: 41.8781, lat: -87.6298), zipcode: "60602"),
        Location(id:"cnq02aso" ,name: "New York", coordinate: Coordinate(lon: 40.7128, lat: -74.0060), zipcode: "10019"),
        Location(id:"achsj498" ,name: "San Francisco", coordinate: Coordinate(lon: 37.7749, lat: -122.4194), zipcode: "94105")
    ]
    
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

