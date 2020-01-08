//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/28/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import SwiftUI
import CoreLocation

struct WeatherListView: View {
    private var mapDelegate: MapDelegate = {
        let mapDelegate = MapDelegate.init { location in
            
        }
        return mapDelegate
    }()
    @EnvironmentObject var storedLocations: LocationStore
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    NavigationLink(destination: WeatherDynamicContainer()) {
                        Text("Select from Map")
                    }
                }
                
                ForEach(storedLocations.store) { location in
                    NavigationLink(destination: WeatherContainer(zipcode: location.zipcode, weather: nil)) {
                        LocationRow(location: location)
                    }
                }
                
            }.navigationBarTitle(Text("Locations"))
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
#endif
