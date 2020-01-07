//
//  Const.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/3/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation

public func const<A, B>(_ a: A) -> (B) -> A {
  return { _ in a }
}
