//
//  GithubAPI.swift
//  MoyaUnbox
//

import Moya

let GithubProvider = MoyaProvider<GitHubAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])

public enum GitHubAPI {
  case Zen
  case UserProfile(String)
  case Users
}

extension GitHubAPI: TargetType {
  public var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }

  public var path: String {
    switch self {
    case .Zen:
      return "/zen"
    case .UserProfile(let name):
      return "/users/\(name.URLEscapedString)"
    case .Users:
      return "/users"
    }
  }

  public var method: Moya.Method {
    return .GET
  }

  public var parameters: [String: AnyObject]? {
    return nil
  }

  public var sampleData: NSData {
    switch self {
    case .Zen:
      return "It's not fully shipped until it's fast.".data
    case .UserProfile(_):
      return "{\"login\":\"JaviLorbada\",\"id\":1939155,\"avatar_url\":\"https://avatars.githubusercontent.com/u/1939155?v=3\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/JaviLorbada\",\"html_url\":\"https://github.com/JaviLorbada\",\"followers_url\":\"https://api.github.com/users/JaviLorbada/followers\",\"following_url\":\"https://api.github.com/users/JaviLorbada/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/JaviLorbada/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/JaviLorbada/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/JaviLorbada/subscriptions\",\"organizations_url\":\"https://api.github.com/users/JaviLorbada/orgs\",\"repos_url\":\"https://api.github.com/users/JaviLorbada/repos\",\"events_url\":\"https://api.github.com/users/JaviLorbada/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/JaviLorbada/received_events\",\"type\":\"User\",\"site_admin\":false,\"name\":\"Javi Lorbada\",\"company\":null,\"blog\":\"http://javilorbada.me/\",\"location\":\"Amsterdam, North Holland, Netherlands.\",\"email\":\"javugi@gmail.com\",\"hireable\":true,\"bio\":null,\"public_repos\":9,\"public_gists\":2,\"followers\":16,\"following\":0,\"created_at\":\"2012-07-08T18:39:06Z\",\"updated_at\":\"2016-08-08T09:40:43Z\"}".data
    case .Users():
      return "[{\"login\":\"mojombo\",\"id\":1,\"avatar_url\":\"https://avatars.githubusercontent.com/u/1?v=3\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/mojombo\",\"html_url\":\"https://github.com/mojombo\",\"followers_url\":\"https://api.github.com/users/mojombo/followers\",\"following_url\":\"https://api.github.com/users/mojombo/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/mojombo/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/mojombo/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/mojombo/subscriptions\",\"organizations_url\":\"https://api.github.com/users/mojombo/orgs\",\"repos_url\":\"https://api.github.com/users/mojombo/repos\",\"events_url\":\"https://api.github.com/users/mojombo/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/mojombo/received_events\",\"type\":\"User\",\"site_admin\":false},{\"login\":\"defunkt\",\"id\":2,\"avatar_url\":\"https://avatars.githubusercontent.com/u/2?v=3\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/defunkt\",\"html_url\":\"https://github.com/defunkt\",\"followers_url\":\"https://api.github.com/users/defunkt/followers\",\"following_url\":\"https://api.github.com/users/defunkt/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/defunkt/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/defunkt/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/defunkt/subscriptions\",\"organizations_url\":\"https://api.github.com/users/defunkt/orgs\",\"repos_url\":\"https://api.github.com/users/defunkt/repos\",\"events_url\":\"https://api.github.com/users/defunkt/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/defunkt/received_events\",\"type\":\"User\",\"site_admin\":true},{\"login\":\"pjhyett\",\"id\":3,\"avatar_url\":\"https://avatars.githubusercontent.com/u/3?v=3\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/pjhyett\",\"html_url\":\"https://github.com/pjhyett\",\"followers_url\":\"https://api.github.com/users/pjhyett/followers\",\"following_url\":\"https://api.github.com/users/pjhyett/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/pjhyett/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/pjhyett/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/pjhyett/subscriptions\",\"organizations_url\":\"https://api.github.com/users/pjhyett/orgs\",\"repos_url\":\"https://api.github.com/users/pjhyett/repos\",\"events_url\":\"https://api.github.com/users/pjhyett/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/pjhyett/received_events\",\"type\":\"User\",\"site_admin\":true}]".data
    }
  }

  public var multipartBody: [Moya.MultipartFormData]? {
    return nil
  }
}

public func url(route: TargetType) -> String {
  return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
