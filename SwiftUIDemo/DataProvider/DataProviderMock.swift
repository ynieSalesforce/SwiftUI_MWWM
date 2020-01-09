//
//  DataProviderMock.swift
//  SwiftUIDemoTests
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

@testable import SwiftUIDemo

struct DataProviderMock: DataProviderType {
    func load<A>(_ query: LoadCriteria<A>) -> SignalProducer<A, DataLoadingError> where A : Decodable {
        switch query.endPoint {
        case .Weather: return SignalProducer<Weather, DataLoadingError>.init(value: Weather.createMock()) as! SignalProducer<A, DataLoadingError>
        }
    }
}
