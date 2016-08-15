//
//  HelperExtensions.swift
//  MoyaUnbox
//

import Foundation

// MARK: - Provider support
extension String {
  var URLEscapedString: String {
    return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
  }

  var data: NSData {
    return self.dataUsingEncoding(NSUTF8StringEncoding)!
  }
}
