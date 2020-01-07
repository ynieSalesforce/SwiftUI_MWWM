//
//  Weather.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/31/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import Overture
import ReactiveSwift

struct Weather: Codable, Equatable {
    let coord: Coordinate
    let weather: [WeatherDescription]
    let main: Main
    let sys: Sys
    let name: String
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        let idsEqual = lhs.sys.id == rhs.sys.id
        let mainEqual = lhs.main.temp == rhs.main.temp
        return idsEqual && mainEqual
    }
}

struct Coordinate: Codable, Hashable {
    let lon: Float
    let lat: Float
}

struct WeatherDescription: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Float
    let humidity: Float
}

extension Main {
    var tempLow: Int {
        return Int(kelvinToFahrenheit(temp_min))
    }
    
    var tempHigh: Int {
        return Int(kelvinToFahrenheit(temp_max))
    }
    
    var tempCurrent: Int {
        return Int(kelvinToFahrenheit(temp))
    }
    
    var feelsLikeTemp: Int {
        return Int(kelvinToFahrenheit(feels_like))
    }
    
    private var kelvinToFahrenheit: (Float) -> Float {
        return pipe(convertToCelsius, convertToFahrenheit)
    }
    
    private func convertToFahrenheit(_ celsius: Float ) -> Float {
        return celsius * (9/5) + 32
    }
    
    private func convertToCelsius(_ kelvin: Float) -> Float {
        return kelvin - 273.15
    }
}

struct Wind: Codable {
    let speed: Float
}

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
    let id: Int
}

extension Sys {
    var sunriseTime: String {
        return displayDate(sunrise)
    }
    
    var sunsetTime: String {
        return displayDate(sunset)
    }
    
    private var displayDate: (Double) -> String {
        return pipe(timeIntervalToDate, dateToDisplay)
    }
    
    private func timeIntervalToDate(_ timeInterval: Double) -> Date {
        return Date.init(timeIntervalSince1970: timeInterval)
    }
    
    private func dateToDisplay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}
