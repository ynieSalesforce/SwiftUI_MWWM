//
//  LoadCriteria.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 12/31/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

public struct LoadCriteria<A: Decodable> {
    let endPoint: EndPoint
    let decoder: ResponseDecoder<A>
}

enum EndPoint {
    case Weather(zipcode: String)
}

extension EndPoint {
    enum URLScheme: String {
        case http
        case https
    }
    
    var url: URL? {
        switch self {
        case .Weather(let zipCode):
            return buildURL(.http, "api.openweathermap.org", "/data/2.5/weather", ["zip": "\(zipCode),us", "APPID": appID])
        }
    }
    
    private func buildURL(_ scheme: URLScheme, _ host: String, _ path: String, _ queryItems: [String: String]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        if let queryItems = queryItems {
            let urlQueryItems = queryItems.map {URLQueryItem(name: $0.key, value: $0.value)}
            components.queryItems = urlQueryItems
        }
        return components.url
    }
    
    private var appID: String {
        return Bundle.main.object(forInfoDictionaryKey: "APP ID") as? String ?? ""
    }
}
