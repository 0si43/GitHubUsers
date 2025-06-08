//
//  GitHubUser.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

public struct GitHubUser: Codable, Hashable, Identifiable {
    public let id: Int
    public let login: String
    public let name: String?
    public let avatarUrl: String
    public let htmlUrl: String
    // detail information
    public let followers: Int?
    public let following: Int?
    public init(id: Int, login: String, name: String? = nil, avatarUrl: String, htmlUrl: String, followers: Int? = nil, following: Int? = nil) {
        self.id = id
        self.login = login
        self.name = name
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.followers = followers
        self.following = following
    }
    
    public static func mock(id: Int) -> GitHubUser {
        .init(id: id, login: "login", name: "name", avatarUrl: "avatarUrl", htmlUrl: "htmlUrl", followers: 100, following: 100)
    }
}
