//
//  Response+Unbox.swift
//  MoyaUnbox
//

import Moya
import Unbox

public extension Response {

  /**
   Maps response data into a model object that conforms Unboxable protocol

   - parameter type: Unboxable protocol object
   - throws: JSONMapping on failure
   - returns: Model object of type T
   */
  public func mapObject<T: Unboxable>(type: T.Type) throws -> T {
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
  public func mapArray<T: Unboxable>(type: T.Type) throws -> [T] {
    guard let JSON = try mapJSON() as? [UnboxableDictionary]
      else {
        throw Error.JSONMapping(self)
    }
    return try Unbox(JSON)
  }
}
