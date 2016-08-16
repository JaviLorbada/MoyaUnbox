//
//  ReactiveMoyaUnboxTests.swift
//  ReactiveMoyaUnboxTests
//

import Quick
import Nimble
import Unbox
import ReactiveMoya
import ReactiveCocoa
@testable import ReactiveMoyaUnbox

class ReactiveMoyaUnboxTests: QuickSpec {
  override func spec() {
    let provider = ReactiveCocoaMoyaProvider<GitHubAPI>(stubClosure: ReactiveCocoaMoyaProvider.DelayedStub(1), plugins: [NetworkLoggerPlugin(verbose: true)])

    it("Should get a GHUser given the user login") {
      var equal = false
      provider.request(.UserProfile("JaviLorbada"))
        .filterSuccessfulStatusCodes()
        .mapObject(GHUser)
        .observeOn(UIScheduler())
        .startWithResult { result in
        if let user = result.value {
          print("User: \(user)")
          equal = user == javiGHUser
        } else { equal = false }
      }
      expect(equal).toEventually(beTruthy(), timeout: 3)
    }

    it("Should return a GHUser array") {
      var GHUsers: [GHUser] = []
      var equal = false
      provider.request(.Users)
        .filterSuccessfulStatusCodes()
        .mapArray(GHUser)
        .observeOn(UIScheduler())
        .startWithResult { result in
          if let users = result.value {
            print("Users: \(users)")
            GHUsers = users
            equal = users.first == mojomboGHUser
          } else { equal = false }
      }
      expect(GHUsers.count).toEventually(be(3), timeout: 3)
      expect(equal).toEventually(beTruthy(), timeout: 3)
    }
  }
}
