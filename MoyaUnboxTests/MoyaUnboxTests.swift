//
//  MoyaUnboxTests.swift
//  MoyaUnboxTests
//

import Quick
import Nimble
import Unbox
import Moya
@testable import MoyaUnbox

class MoyaUnboxTests: QuickSpec {

  override func spec() {

    let javiGHUser = GHUser(login: "JaviLorbada",
                      identifier: 1939155,
                      avatarURL: NSURL(string: "https://avatars.githubusercontent.com/u/1939155?v=3")!,
                      url: NSURL(string: "https://api.github.com/users/JaviLorbada")!,
                      reposURL: NSURL(string: "https://api.github.com/users/JaviLorbada/repos")!,
                      type: "User",
                      siteAdmin: false,
                      blog: "http://javilorbada.me/",
                      location: "Amsterdam, North Holland, Netherlands.",
                      email: "javugi@gmail.com",
                      publicRepos: 9,
                      publicGists: 2)

    let mojomboGHUser = GHUser(login: "mojombo",
                            identifier: 1,
                            avatarURL: NSURL(string: "https://avatars.githubusercontent.com/u/1?v=3")!,
                            url: NSURL(string: "https://api.github.com/users/mojombo")!,
                            reposURL: NSURL(string: "https://api.github.com/users/mojombo/repos")!,
                            type: "User",
                            siteAdmin: false,
                            blog: nil,
                            location: nil,
                            email: nil,
                            publicRepos: nil,
                            publicGists: nil)

    let provider = MoyaProvider<GitHubAPI>(stubClosure: MoyaProvider.DelayedStub(1), plugins: [NetworkLoggerPlugin(verbose: true)])

    it("should get a GHUser given the user login") {
      var equal = false
      provider.request(.UserProfile("JaviLorbada"), completion: { result in
        do {
          if let user = try result.value?.mapObject(GHUser) {
            print("User: \(user)")
            equal = user == javiGHUser
          } else {
            equal = false }
        } catch {
          equal = false
        }
      })
      expect(equal).toEventually(beTruthy(), timeout: 3)
    }

    it("should return a GHUser array") {
      var GHUsers: [GHUser] = []
      var equal = false
      provider.request(.Users, completion: { result in
        do {
          if let users = try result.value?.mapArray(GHUser) {
            GHUsers = users
            print("Users: \(users)")
            equal = users.first == mojomboGHUser
          } else {
            equal = false }
        } catch {
          equal = false
        }
      })
      expect(GHUsers.count).toEventually(be(3), timeout: 3)
      expect(equal).toEventually(beTruthy(), timeout: 3)
    }
  }
}
