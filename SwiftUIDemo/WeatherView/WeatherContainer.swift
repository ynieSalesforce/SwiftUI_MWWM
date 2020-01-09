//
//  WeatherContainer.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import UIKit
import SwiftUI
import ReactiveSwift
import ReactiveCocoa

struct WeatherContainer: View {
    var zipcode: String
    let lifeCycle: ViewLifeCycle = ViewLifeCycle()
    
    @State var weather: Weather?
    @State private var showingErrorAlert = false
    var body: some View {
        VStack {
            buildView(with: weather)
        }.onAppear(perform: loadWeather)
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Oh No!"), message: Text("We're so sorry, but it looks like there's something wrong with our servers, check back later!"), dismissButton: .default(Text("Got it!")))
        }
    }
    
    private func buildView(with weather:Weather?) -> AnyView {
        guard let weather = weather else {
            return AnyView(Text("Retrieving Weather").font(.title))
        }
        return AnyView(WeatherInfoView(weather: weather))
    }
    
    private func loadWeather() {
        let output = WeatherViewModel.create(WeatherViewModel.Input.init(zipcode: zipcode, lifeCycle: lifeCycle))
        output.weather
            .observeForControllerAction()
            .observeValues { weather in
                self.weather = weather
        }
        
        output.errors
        .observeForControllerAction()
            .observeValues { error in
                self.showingErrorAlert = true
        }
        lifeCycle.viewDidLoad()
    }
}

struct WeatherContainer_Previews: PreviewProvider {
    static var previews: some View {
        WeatherContainer(zipcode: "20001")
    }
}
