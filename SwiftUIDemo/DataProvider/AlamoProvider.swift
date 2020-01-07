//
//  AlamoProvider.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/31/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

struct AlamoProvider: DataProviderType {
    public func load<A: Decodable>(_ query: LoadCriteria<A>) -> DataProducer<A> {
        return fetch(with: query.endPoint).flatMap(.merge, query.decoder.decode)
    }
    
    private func fetch(with endPoint: EndPoint) -> SignalProducer<Data, DataLoadingError> {
        return SignalProducer<Data, DataLoadingError> { observer, _ in
            guard let url = endPoint.url else {
                observer.send(error: .networkError)
                return
            }
            Alamofire.request(url).validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .failure( let error ):
                        observer.send(error: .badResponse(error))
                    case .success(let data):
                        observer.send(value: data)
                    }
            }
        }
    }
}

struct ResponseDecoder<A> where A: Decodable {
    let decode: (Data) -> DataProducer<A>
}

extension ResponseDecoder where A: Decodable {
    static var decodable: ResponseDecoder {
        return ResponseDecoder { value in
            return resultToDataProducer(decodeResult(value))
        }
    }
}

private func resultToDataProducer<A>(_ result: Result<A>) -> DataProducer<A> {
  switch result {
  case let .success(value): return DataProducer(value: value)
  case let .failure(decodeError):
    return DataProducer(error: DataLoadingError.badResponse(decodeError))
  }
}

private func decodeResult<T: Decodable>(_ data: Data) -> Result<T> {
    let decoder = JSONDecoder()
  do {
    let decoded = try decoder.decode(T.self, from: data)
    return .success(decoded)
  } catch (let error) {
    return .failure(DataLoadingError.badResponse(error))
  }
}
