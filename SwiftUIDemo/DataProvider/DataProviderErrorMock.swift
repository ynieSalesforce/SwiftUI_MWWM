//
//  DataProviderErrorMock.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift
@testable import SwiftUIDemo

struct DataProviderErrorMock: DataProviderType {
  let errorStub: DataLoadingError

  init(errorStub: DataLoadingError = .badResponse(.none)) {
    self.errorStub = errorStub
  }

  func load<A>(_ query: LoadCriteria<A>) -> SignalProducer<A, DataLoadingError> where A : Decodable {
    return .init(error: errorStub)
  }
}
