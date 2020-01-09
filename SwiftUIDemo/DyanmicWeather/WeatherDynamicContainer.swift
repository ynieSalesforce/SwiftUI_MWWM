//
//  WeatherDynamicContainer.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI
import ReactiveSwift
import MapKit

struct WeatherDynamicContainer: View {
    
    private var zipcode: MutableProperty<String> = MutableProperty.init("")
    let lifeCycle: ViewLifeCycle = ViewLifeCycle()
    
    @State var weather: Weather?
    @State private var showingErrorAlert = false
    var body: some View {
        VStack {
            loadHeaderView(from: weather)
            MapViewSelectable(viewDidUpdate: { coordinate -> Void in
                self.loadLocation(from: coordinate)
            }, initialCoordinate: Coordinate(lon: -77.0369, lat: 38.9072)).frame(height: 350)

            loadWeatherView(from: weather)
            Spacer()
        }.onAppear(perform: loadWeather)
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Oh No!"), message: Text("We're so sorry, but it looks like there's something wrong with our servers, check back later!"), dismissButton: .default(Text("Got it!")))
        }
    }
    
    private func loadWeatherView(from weather: Weather?) -> AnyView{
        guard let weather = weather else {
            return AnyView(Text("Drag map to get weather"))
        }
        return AnyView(WeatherInfoStack(weather: weather))
    }
    
    private func loadHeaderView(from weather: Weather?) -> AnyView {
        guard let weather = weather else {
            return AnyView(Text("Map").font(.title).fontWeight(.semibold))
        }
        return AnyView(
            VStack {
                Text(weather.name)
                    .font(.title).fontWeight(.semibold)
                    
                Text(weather.weather[0].description)
                    .font(.subheadline).fontWeight(.semibold)
            }
        )
    }
    
    private func loadLocation(from coordinate: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            guard let placemark = placemark,
                let mapLocation = placemark.first,
                let zip = mapLocation.postalCode  else {return}
            self.zipcode.value = zip
        }
    }
    
    private func loadWeather() {
        let output = WeatherDynamicViewModel.create(WeatherDynamicViewModel.Input.init(zipcode: zipcode, lifeCycle: lifeCycle))
            
        output.weather
        .observeForControllerAction()
            .observeValues({ weather in
                self.weather = weather
            })
        
        output.error.observeForControllerAction()
            .observeValues { error in
                self.showingErrorAlert = true
        }
        lifeCycle.viewDidLoad()
    }
}

struct WeatherDynamicContainer_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDynamicContainer()
    }
}
