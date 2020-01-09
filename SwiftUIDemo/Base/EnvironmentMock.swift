//
//  EnvironmentMock.swift
//  SwiftUIDemoTests
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

@testable import SwiftUIDemo

extension Environment {
    static var mock: Environment {
        Environment( config: MockAppConfig(),
                     scheduler: TestScheduler(),
                    dataProvider: DataProviderMock(),
                    locationStore: LocationStore())
    }
}
