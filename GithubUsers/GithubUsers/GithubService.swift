//
//  GithubService.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import SwiftUI

private struct GitHubAPIConfig {
    static let baseURL = "https://api.github.com"
    
    static var authHeaders: [String: String] {
        return if let personalAccessToken = ProcessInfo.processInfo.environment["GITHUB_PAT"] {
            [
                "Authorization": "Bearer \(personalAccessToken)",
                "Accept": "application/vnd.github+json",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        } else {
            [:]
        }
    }
}

protocol GitHubServiceProtocol {
    func fetchUsers() async -> [GitHubUser]
}

class GitHubService: GitHubServiceProtocol {
    func fetchUsers() async -> [GitHubUser] {
        []
    }
}

class GitHubServiceMock: GitHubServiceProtocol {
    var users: [GitHubUser] = []
    func fetchUsers() async -> [GitHubUser] {
        users
    }
}
