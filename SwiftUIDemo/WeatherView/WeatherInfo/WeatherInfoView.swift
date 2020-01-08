//
//  WeatherInfoView.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI

struct WeatherInfoView: View {
    let weather: Weather
    
    var body: some View {
        VStack {
            Text(weather.name).font(.title).fontWeight(.semibold)
            Text(weather.weather[0].description).font(.body)
            MapView(delegate: nil, location: weather.coord)
                .frame(height: 350)
            WeatherInfoStack(weather: weather)
            Spacer()
        }
    }
}

struct WeatherInfoStack: View {
    let weather: Weather
    
    var body: some View {
        VStack {
            WeatherInfoRow(key: "Current Temperature", value: "\(weather.main.tempCurrent) F")
            WeatherInfoRow(key: "Feels like", value: "\(weather.main.feelsLikeTemp) F")
            WeatherInfoRow(key: "Low", value: "\(weather.main.tempLow) F")
            WeatherInfoRow(key: "High", value: "\(weather.main.tempHigh) F")
            WeatherInfoRow(key: "Sunrise", value: weather.sys.sunriseTime)
            WeatherInfoRow(key: "Sunset", value: weather.sys.sunsetTime)
        }
    }
}

struct WeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoView(weather: .createMock())
    }
}
