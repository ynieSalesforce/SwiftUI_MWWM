//
//  WeatherMock.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation

extension Weather {
    static func createMock(
        coord: Coordinate = .createMock(),
        weatherDesc: [WeatherDescription] = [WeatherDescription.createMock()],
        main: Main = .createMock(),
        sys: Sys = .createMock(),
        name: String = "Washington"
    ) -> Weather {
        Weather.init(coord: coord,
                     weather: weatherDesc,
                     main: main,
                     sys: sys,
                     name: name)
    }
}

extension Coordinate {
    static func createMock(
        lon: Float = 123,
        lat: Float = -136.67
    ) -> Coordinate {
        Coordinate(lon: lon, lat: lat)
    }
}

extension WeatherDescription {
    static func createMock (
        id: Int = 123,
        main: String = "Clear",
        description: String = "Sunny",
        icon: String = "01d"
    ) -> WeatherDescription {
        WeatherDescription(id: id, main: main, description: description, icon: icon)
    }
}

extension Main {
    static func createMock(
        temp: Float = 282.13,
        feelsLike: Float = 278.74,
        tempMin: Float = 279.82,
        tempMax: Float = 284.26,
        pressure: Float = 1014,
        humidity: Float = 55
    ) -> Main {
        Main(temp: temp, feels_like: feelsLike, temp_min: tempMin, temp_max: tempMax, pressure: pressure, humidity: humidity)
    }
}

extension Sys {
    static func createMock(
        sunrise: Double = 1577968041,
        sunset: Double = 1578002136,
        id: Int = 4115
    ) -> Sys {
        Sys(sunrise: sunrise, sunset: sunset, id: id)
    }
}
