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
        var zipcode: MutableProperty<String>
        var lifeCycle: ViewLifeCycle
    }
    
    public struct Output {
        var weather: Signal<Weather, DataLoadingError>
        var dataIsLoading: Signal<Bool, Never>
    }
    
    static var create = createViewModel
}

private func createViewModel(input: WeatherViewModel.Input) -> WeatherViewModel.Output {
    let scheduler = Environment.current.scheduler
    let onLoad = input.lifeCycle.viewDidLoadProperty.signal.observe(on: scheduler)
    
    var zipcode: String?
    input.zipcode.signal.observe(on: Environment.current.scheduler)
        .observeValues{zipcode = $0}
    
    let criteriaForLoad = onLoad.flatMap(.latest, const(input.zipcode.signal.observe(on: scheduler)))
        .map { input in
            LoadCriteria(endPoint: .Weather(zipcode: zipcode!),
                         decoder: ResponseDecoder<Weather>.decodable)
    }
    let (onLoadIndicator, data) = mapWithIndicator(criteriaForLoad.map(loadData))
    return .init(weather: data, dataIsLoading: onLoadIndicator)
}

private func loadData<A: Decodable>(criteria: LoadCriteria<A>) -> SignalProducer<A, DataLoadingError>{
    let provider = Environment.current.dataProvider
    return provider.load(criteria)
}
