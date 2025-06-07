//
//  GitHubUser.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

struct GitHubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, login, type
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
