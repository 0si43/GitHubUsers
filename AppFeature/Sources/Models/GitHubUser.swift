//
//  GitHubUser.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

public struct GitHubUser: Codable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let login: String
    public let avatarUrl: String
    public let htmlUrl: String
    // detail information
    public let name: String?
    public let followers: Int?
    public let following: Int?
    public init(id: Int, login: String, avatarUrl: String, htmlUrl: String, name: String? = nil, followers: Int? = nil, following: Int? = nil) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.name = name
        self.followers = followers
        self.following = following
    }
    
    public static func mock(id: Int) -> GitHubUser {
        .init(id: id, login: "login", avatarUrl: "avatarUrl", htmlUrl: "htmlUrl", name: "name", followers: 100, following: 100)
    }
}
