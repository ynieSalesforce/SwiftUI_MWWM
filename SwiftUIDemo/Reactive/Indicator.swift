//
//  Indicator.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/3/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

public func mapWithIndicator<V, E>(_ signal: Signal<SignalProducer<V,E>, Never>) -> (Signal<Bool, Never>, Signal<V,E>) {
    let indicator = MutableProperty<Bool>(false)
    let indicatorSignal = signal.flatMap(.latest) { signal -> SignalProducer<V, E> in
        signal.on(starting: {
            indicator.value = true
        }, terminated: {
            indicator.value = false
        }) { _ in
            indicator.value = false
        }
    }
    return (indicator.signal.skipRepeats(), indicatorSignal)
}
