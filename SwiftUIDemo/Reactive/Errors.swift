//Source: https://github.com/kickstarter/Kickstarter-ReactiveExtensions/blob/master/ReactiveExtensions/operators/Errors.swift

import Foundation
import ReactiveSwift

extension Signal where Value: EventProtocol, Error == Never {
  /**
   - returns: A signal of errors of `Error` events from a materialized signal.
   */
  public func errors() -> Signal<Value.Error, Never> {
    return self.signal.map { $0.event.error }.skipNil()
  }
}

extension SignalProducer where Value: EventProtocol, Error == Never {
  /**
   - returns: A producer of errors of `Error` events from a materialized signal.
   */
  public func errors() -> SignalProducer<Value.Error, Never> {
    return self.lift { $0.errors() }
  }
}
