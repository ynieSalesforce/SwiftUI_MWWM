//
//  Environment.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/3/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

public struct Environment {
    var scheduler: DateScheduler = QueueScheduler(qos: .default, name: "com.salesforce.swiftUIDemo")
    var dataProvider: DataProviderType = AlamoProvider()
}

public extension Environment {
  static var current = Environment()
}
