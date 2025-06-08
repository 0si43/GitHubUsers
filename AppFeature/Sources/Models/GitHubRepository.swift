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
}
