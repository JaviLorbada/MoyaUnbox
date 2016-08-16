//
//  Observable+Unbox.swift
//

import Foundation
import RxSwift
import RxMoya
import Unbox

public extension ObservableType where E == RxMoya.Response {

  /**
   Maps data received from the Observable into an object which conforms the Unboxable protocol.

   - parameter type: Unboxable protocol object
   - returns: Observable with Unboxable object, otherwise the Observable errors
   */
  public func mapObject<T: Unboxable>(type: T.Type) -> Observable<T> {
    return flatMap { response -> Observable<T> in
      return Observable.just(try response.mapObject(T))
    }
  }

  /**
   Maps data received from the Observable into an array objects which conforms the Unboxable protocol.

   - parameter type: Unboxable protocol object
   - returns: Observable with Unboxable object, otherwise the Observable errors
   */
  public func mapArray<T: Unboxable>(type: T.Type) -> Observable<[T]> {
    return flatMap { (response) -> Observable<[T]> in
      return Observable.just(try response.mapArray(T))
    }
  }
}

private extension RxMoya.Response {

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
