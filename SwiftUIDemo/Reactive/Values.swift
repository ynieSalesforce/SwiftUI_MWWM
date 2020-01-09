//source: https://github.com/kickstarter/Kickstarter-ReactiveExtensions/blob/master/ReactiveExtensions/operators/Values.swift
import Foundation
import ReactiveSwift

public extension SignalProducer where Value: EventProtocol, Error == Never {
  /**
   - returns: A producer of values of `Next` events from a materialized signal.
   */
  func values() -> SignalProducer<Value.Value, Never> {
    return lift { $0.values() }
  }
}

public extension Signal where Value: EventProtocol, Error == Never {
  /**
   - returns: A signal of values of `Next` events from a materialized signal.
   */
  func values() -> Signal<Value.Value, Never> {
    return signal.map { $0.event.value }.skipNil()
  }
}
