//
//  WeatherViewModelTest.swift
//  SwiftUIDemoTests
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift

@testable import SwiftUIDemo

class WeatherViewModelTest: QuickSpec {
    override func spec() {
        let lifecycle = ViewLifeCycle()
        let scheduler = TestScheduler()
        var output: WeatherViewModel.Output!
        
        beforeEach {
            Environment.current = .mock
            Environment.current.scheduler = scheduler
        }
        
        describe("Weather view model") {
            it("Loads data properly") {
                let dataObserver = TestObserver<Weather, Never>()
                let errorObserver = TestObserver<DataLoadingError, Never>()
                output = WeatherViewModel
                    .create(.init(zipcode: "20001", lifeCycle: lifecycle))
                
                output.weather.observe(dataObserver.observer)
                output.errors.observe(errorObserver.observer)
                
                lifecycle.viewDidLoad()
                scheduler.run()
                
                dataObserver.assertDidEmitValue()
                let value = dataObserver.values.first
                
                expect(value).toNot(beNil())
            }
            
            it("Sends error") {
                Environment.current.dataProvider = DataProviderErrorMock()
                let dataObserver = TestObserver<Weather, Never>()
                let errorObserver = TestObserver<DataLoadingError, Never>()
                output = WeatherViewModel
                    .create(.init(zipcode: "20001", lifeCycle: lifecycle))
                
                output.weather.observe(dataObserver.observer)
                output.errors.observe(errorObserver.observer)
                
                lifecycle.viewDidLoad()
                scheduler.run()
                expect(errorObserver.didEmitValue).to(beTrue())
            }
        }
    }
}
