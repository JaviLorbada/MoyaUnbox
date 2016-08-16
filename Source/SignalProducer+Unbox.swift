//
//  SignalProducer+Unbox.swift
//

import Foundation
import ReactiveCocoa
import ReactiveMoya
import Unbox

public extension SignalProducerType where Value == ReactiveMoya.Response, Error == ReactiveMoya.Error {

  /**
   Maps data received from the signal into an object which conforms the Unboxable protocol.

   - parameter type: Unboxable protocol object
   - returns: SignalProducer with Unboxable object, otherwise the signal errors
  */
  public func mapObject<T: Unboxable>(type: T.Type) -> SignalProducer<T, ReactiveMoya.Error> {
    return producer.flatMap(.Latest) { response -> SignalProducer<T, ReactiveMoya.Error> in
      return unwrapThrowable { try response.mapObject(T) }
    }
  }

  /**
   Maps data received from the signal into an array objects which conforms the Unboxable protocol.

   - parameter type: Unboxable protocol object
   - returns: SignalProducer with Unboxable object, otherwise the signal errors
   */
  public func mapArray<T: Unboxable>(type: T.Type) -> SignalProducer<[T], ReactiveMoya.Error> {
    return producer.flatMap(.Latest) { response -> SignalProducer<[T], ReactiveMoya.Error> in
      return unwrapThrowable { try response.mapArray(T) }
    }
  }
}

private extension ReactiveMoya.Response {

  /**
   Maps response data into a model object that conforms Unboxable protocol

   - parameter type: Unboxable protocol object
   - throws: JSONMapping on failure
   - returns: Model object of type T
   */
  private func mapObject<T: Unboxable>(type: T.Type) throws -> T {
    guard let JSON = try mapJSON() as? UnboxableDictionary else {
      throw Error.JSONMapping(self)
    }
    return try Unbox(JSON)
  }

  /**
   Maps response data into an array of model objects that conforms Unboxable protocol

   - parameter type: Unboxable protocol object
   - throws: JSONMapping on failure
   - returns: Array of model objects of type T
   */
  private func mapArray<T: Unboxable>(type: T.Type) throws -> [T] {
    guard let JSON = try mapJSON() as? [UnboxableDictionary]
      else {
        throw Error.JSONMapping(self)
    }
    return try Unbox(JSON)
  }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(throwable: () throws -> T) -> SignalProducer<T, ReactiveMoya.Error> {
  do {
    return SignalProducer(value: try throwable())
  } catch {
    if let error = error as? ReactiveMoya.Error {
      return SignalProducer(error: error)
    } else {
      // The cast above should never fail, but just in case.
      return SignalProducer(error: ReactiveMoya.Error.Underlying(error as NSError))
    }
  }
}
