//
//  RxMoyaUnboxTests.swift
//  RxMoyaUnboxTests
//
import Quick
import Nimble
import Unbox
import RxMoya
import RxSwift
@testable import RxMoyaUnbox

class ReactiveMoyaUnboxTests: QuickSpec {
  override func spec() {
    let disposeBag = DisposeBag()
    let provider = RxMoyaProvider<GitHubAPI>(stubClosure: RxMoyaProvider.DelayedStub(1), plugins: [NetworkLoggerPlugin(verbose: true)])

    it("Should get a GHUser given the user login") {
      var equal = false
      provider.request(.UserProfile("JaviLorbada"))
        .filterSuccessfulStatusCodes()
        .mapObject(GHUser)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { user in
          print("User: \(user)")
          equal = user == javiGHUser
        }, onError: { _ in equal = false})
        .addDisposableTo(disposeBag)

      expect(equal).toEventually(beTruthy(), timeout: 3)
    }

    it("Should return a GHUser array") {
      var GHUsers: [GHUser] = []
      var equal = false
      provider.request(.Users)
        .filterSuccessfulStatusCodes()
        .mapArray(GHUser)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { users in
          print("Users: \(users)")
          GHUsers = users
          equal = users.first == mojomboGHUser
        }, onError: { _ in equal = false})
        .addDisposableTo(disposeBag)

      expect(GHUsers.count).toEventually(be(3), timeout: 3)
      expect(equal).toEventually(beTruthy(), timeout: 3)
    }
  }
}
