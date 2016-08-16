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

    let provider = MoyaProvider<GitHubAPI>(stubClosure: MoyaProvider.DelayedStub(1), plugins: [NetworkLoggerPlugin(verbose: true)])

    it("Should get a GHUser given the user login") {
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

    it("Should return a GHUser array") {
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
