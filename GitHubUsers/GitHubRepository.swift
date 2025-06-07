//
//  GitHubRepository.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

struct GitHubRepository: Codable, Hashable {
    let name: String
    let language: String?
    let stargazersCount: Int
    let description: String?
    let fork: Bool
    let htmlUrl: String
}
