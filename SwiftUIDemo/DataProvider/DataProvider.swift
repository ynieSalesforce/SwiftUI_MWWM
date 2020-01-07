//
//  DataProvider.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/31/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

public typealias DataProducer<T> = SignalProducer<T, DataLoadingError>

protocol DataProviderType {
    func load<A: Decodable>(_ query: LoadCriteria<A>) -> DataProducer<A>
}
