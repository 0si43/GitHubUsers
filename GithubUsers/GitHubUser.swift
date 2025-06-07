//
//  GitHubUser.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

struct GitHubUser: Codable, Hashable, Identifiable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int?
    let following: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, login, name, followers, following
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
    
    static func mock(id: Int) -> GitHubUser {
        .init(id: id, login: "login", name: "name", avatarUrl: "avatarUrl", htmlUrl: "htmlUrl", followers: 100, following: 100)
    }
}
