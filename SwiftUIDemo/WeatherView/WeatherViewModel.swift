//
//  WeatherViewModel.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/3/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

public struct WeatherViewModel {
    public struct Input {
        var zipcode: String
        var lifeCycle: ViewLifeCycle
    }
    
    public struct Output {
        var weather: Signal<Weather, Never>
        var errors: Signal<DataLoadingError, Never>
        var dataIsLoading: Signal<Bool, Never>
    }
    
    static var create = createViewModel
}

private func createViewModel(input: WeatherViewModel.Input) -> WeatherViewModel.Output {
    let scheduler = Environment.current.scheduler
    let onLoad = input.lifeCycle.viewDidLoadProperty.signal.observe(on: scheduler)
    
    let criteriaForLoad = onLoad
        .map { _ in
            LoadCriteria(endPoint: .Weather(zipcode: input.zipcode),
                         decoder: ResponseDecoder<Weather>.decodable)
    }
    
    let (onLoadIndicator, data) = mapWithIndicator(criteriaForLoad.map(loadData))
    return .init(weather: data.values(), errors: data.errors(), dataIsLoading: onLoadIndicator)
}

private func loadData<A: Decodable>(criteria: LoadCriteria<A>) -> SignalProducer<Signal<A, DataLoadingError>.Event, Never>{
    let provider = Environment.current.dataProvider
    return provider.load(criteria).materialize()
}
