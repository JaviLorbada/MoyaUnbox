//
//  GithubAPI.swift
//  MoyaUnbox
//

import ReactiveMoya

enum GitHubAPI {
  case Zen
  case UserProfile(String)
  case Users
}

extension GitHubAPI: ReactiveMoya.TargetType {
  var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }

  var path: String {
    switch self {
    case .Zen:
      return "/zen"
    case .UserProfile(let name):
      return "/users/\(name.URLEscapedString)"
    case .Users:
      return "/users"
    }
  }

  var method: ReactiveMoya.Method {
    return .GET
  }

  var parameters: [String: AnyObject]? {
    return nil
  }

  var sampleData: NSData {
    switch self {
    case .Zen:
      return "It's not fully shipped until it's fast.".data
    case .UserProfile(_):
      return userProfileResponse
    case .Users():
      return usersResponse
    }
  }

  var multipartBody: [ReactiveMoya.MultipartFormData]? {
    return nil
  }
}
