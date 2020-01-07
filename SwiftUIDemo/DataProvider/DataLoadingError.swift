//
//  DataLoadingError.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/31/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

public enum DataLoadingError: Error {
  case unknown(String)
  case errorWithStatusCode(Int)
  case badResponse(Error?)
  case networkError

  public var errorDescription: String? {
    switch self {
    case let .errorWithStatusCode(code):
      return "\(code) Error Code"
    case .networkError:
      return "Network Error"
    case .badResponse:
      return "Bad Response"
    default:
      return "Unexpected Error"
    }
  }
}
