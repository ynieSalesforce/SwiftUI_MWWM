//
//  WeatherDynamicViewModelTest.swift
//  SwiftUIDemoTests
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift

@testable import SwiftUIDemo

class WeatherDynamicViewModelTest: QuickSpec {
    override func spec() {
        let lifecycle = ViewLifeCycle()
        let scheduler = TestScheduler()
        var output: WeatherDynamicViewModel.Output!
        
        beforeEach {
            Environment.current = .mock
            Environment.current.scheduler = scheduler
        }
        
        describe("Weather dynamic view model") {
            it("Loads data properly") {
                let dataObserver = TestObserver<Weather, Never>()
                let errorObserver = TestObserver<DataLoadingError, Never>()
                let zipcode = MutableProperty<String>.init("20001")
                output = WeatherDynamicViewModel
                    .create(.init(zipcode: zipcode, lifeCycle: lifecycle))
                
                output.weather.observe(dataObserver.observer)
                output.error.observe(errorObserver.observer)
                
                lifecycle.viewDidLoad()
                scheduler.run()
                zipcode.value = "20001"
                scheduler.run()
                expect(dataObserver.didEmitValue).to(beTrue())
                expect(dataObserver.values.first).toEventuallyNot(beNil())
            }
            
            it("Sends error") {
                Environment.current.dataProvider = DataProviderErrorMock()
                let dataObserver = TestObserver<Weather, Never>()
                let errorObserver = TestObserver<DataLoadingError, Never>()
                let zipcode = MutableProperty<String>.init("20001")
                output = WeatherDynamicViewModel
                    .create(.init(zipcode: zipcode, lifeCycle: lifecycle))
                
                output.weather.observe(dataObserver.observer)
                output.error.observe(errorObserver.observer)
                
                lifecycle.viewDidLoad()
                scheduler.run()
                zipcode.value = "20001"
                scheduler.run()
                expect(errorObserver.didEmitValue).to(beTrue())
            }
        }
    }
}
