//
//  DataProvider.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/31/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

//struct DataQuery<Response> where Response: Decodable {
//  var request: DataRequest
//  let responseDecoder: ResponseDecoding<Response>
//  let isList: Bool
//  init(request: DataRequest, responseDecoder: ResponseDecoding<Response>, isList: Bool = false) {
//    self.request = request
//    self.responseDecoder = responseDecoder
//    self.isList = isList
//  }
//}

public typealias DataProducer<T> = SignalProducer<T, DataLoadingError>

protocol DataProviderType {
    func load<A: Decodable>(_ query: LoadCriteria<A>) -> DataProducer<A>
}
