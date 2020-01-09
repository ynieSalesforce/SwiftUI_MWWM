//
//  WeatherDynamicViewModel.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

public struct WeatherDynamicViewModel {
    public struct Input {
        var zipcode: MutableProperty<String>
        var lifeCycle: ViewLifeCycle
    }
    
    public struct Output {
        var weather: Signal<Weather, Never>
        var error: Signal<DataLoadingError, Never>
        var dataIsLoading: Signal<Bool, Never>
    }
    
    static var create = createViewModel
}

private func createViewModel(input: WeatherDynamicViewModel.Input) -> WeatherDynamicViewModel.Output {
    let scheduler = Environment.current.scheduler
    let onLoad = input.lifeCycle.viewDidLoadProperty.signal.observe(on: scheduler)
    
    let criteriaForLoad = onLoad
        .flatMap(.latest, const(input.zipcode.signal.observe(on: scheduler)))
        .filter({ !$0.isEmpty })
        .debounce(Environment.current.config.mapDelay, on: scheduler)
        .map { zipcode in
            LoadCriteria(endPoint: .Weather(zipcode: zipcode),
                         decoder: ResponseDecoder<Weather>.decodable)
    }
    
    let (onLoadIndicator, data) = mapWithIndicator(criteriaForLoad.map(loadData))
    return .init(weather: data.values(), error: data.errors(), dataIsLoading: onLoadIndicator)
}

private func loadData<A: Decodable>(criteria: LoadCriteria<A>) -> SignalProducer<Signal<A, DataLoadingError>.Event, Never>{
    let provider = Environment.current.dataProvider
    return provider.load(criteria).materialize()
}
