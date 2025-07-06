//
//  GitHubRepository.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

public struct GitHubRepository: Codable, Hashable, Sendable {
    public let name: String
    public let language: String?
    public let stargazersCount: Int
    public let description: String?
    public let fork: Bool
    public let htmlUrl: String
    public init(name: String, language: String? = nil, stargazersCount: Int, description: String? = nil, fork: Bool, htmlUrl: String) {
        self.name = name
        self.language = language
        self.stargazersCount = stargazersCount
        self.description = description
        self.fork = fork
        self.htmlUrl = htmlUrl
    }
}
