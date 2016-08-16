//
//  HelperExtensions.swift
//  MoyaUnbox
//

import Foundation
import Moya

// MARK: - Provider support
extension String {
  var URLEscapedString: String {
    return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
  }

  var data: NSData {
    return self.dataUsingEncoding(NSUTF8StringEncoding)!
  }
}

func url(route: TargetType) -> String {
  return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
