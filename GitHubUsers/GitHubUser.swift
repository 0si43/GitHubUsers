//
//  GitHubUser.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

struct GitHubUser: Codable, Hashable, Identifiable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: String
    let htmlUrl: String
    // detail information
    let followers: Int?
    let following: Int?

    static func mock(id: Int) -> GitHubUser {
        .init(id: id, login: "login", name: "name", avatarUrl: "avatarUrl", htmlUrl: "htmlUrl", followers: 100, following: 100)
    }
}
