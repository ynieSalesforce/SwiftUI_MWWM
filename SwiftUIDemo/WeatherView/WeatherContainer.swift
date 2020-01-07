//
//  WeatherContainer.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI
import ReactiveSwift

struct WeatherContainer: View {
    var zipcode: String
    let lifeCycle: ViewLifeCycle = ViewLifeCycle()
    
    @State var weather: Weather?
    var body: some View {
        VStack {
            buildView(with: weather)
        }.onAppear(perform: loadWeather)
    }
    
    private func buildView(with weather:Weather?) -> AnyView {
        guard let weather = weather else {
            return AnyView(Text("Retrieving Weather").font(.title))
        }
        return AnyView(WeatherInfoView(weather: weather))
    }
    
    private func loadWeather() {
        WeatherViewModel.create(WeatherViewModel.Input.init(zipcode: zipcode, lifeCycle: lifeCycle)).weather.on { weather in
            self.weather = weather
        }.observeCompleted {}
        lifeCycle.viewDidLoad()
    }
}

struct WeatherContainer_Previews: PreviewProvider {
    static var previews: some View {
        WeatherContainer(zipcode: "20001")
    }
}
