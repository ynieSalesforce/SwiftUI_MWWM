//
//  AppConfig.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/9/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation

protocol AppConfigType {
    var mapDelay: Double {get}
}

struct DefaultAppConfig: AppConfigType {
    var mapDelay: Double = 1.25
}
