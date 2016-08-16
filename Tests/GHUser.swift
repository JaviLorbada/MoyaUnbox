//
//  GHUser.swift
//  MoyaUnbox
//

import Foundation
import Unbox

struct GHUser {
  let login: String
  let identifier: Int
  let avatarURL: NSURL
  let url: NSURL
  let reposURL: NSURL
  let type: String
  let siteAdmin: Bool
  let blog: String?
  let location: String?
  let email: String?
  let publicRepos: Int?
  let publicGists: Int?
}

extension GHUser: Unboxable {
  init(unboxer: Unboxer) {
    self.login = unboxer.unbox("login")
    self.identifier = unboxer.unbox("id")
    self.avatarURL = unboxer.unbox("avatar_url")
    self.url = unboxer.unbox("url")
    self.reposURL = unboxer.unbox("repos_url")
    self.type = unboxer.unbox("type")
    self.siteAdmin = unboxer.unbox("site_admin")
    self.blog = unboxer.unbox("blog")
    self.location = unboxer.unbox("location")
    self.email = unboxer.unbox("email")
    self.publicRepos = unboxer.unbox("public_repos")
    self.publicGists = unboxer.unbox("public_gists")
  }
}

// MARK: Equatable for unit tests

extension GHUser: Equatable { }

func == (lhs: GHUser, rhs: GHUser) -> Bool {
  return lhs.login == rhs.login && lhs.identifier == rhs.identifier
}
