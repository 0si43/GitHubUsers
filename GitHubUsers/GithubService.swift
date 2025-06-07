//
//  GitHubService.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import Foundation

// https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
struct GitHubAPIConfig {
    static let baseURL = "https://api.github.com"
    
    static var authHeaders: [String: String] {
        if let personalAccessToken = ProcessInfo.processInfo.environment["GITHUB_PAT"], !personalAccessToken.isEmpty {
            [
                "Authorization": "Bearer \(personalAccessToken)",
                "Accept": "application/vnd.github+json",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        } else {
            [:]
        }
    }
    
    static func usersURL(since: Int) -> URL? {
        URL(string: "\(GitHubAPIConfig.baseURL)/users?since=\(since)")
    }
    
    static func userURL(for id: Int) -> URL? {
        URL(string: "\(GitHubAPIConfig.baseURL)/user/\(id)")
    }
}

protocol GitHubServiceProtocol {
    func fetchUsers(pageNumber: Int) async throws -> [GitHubUser]
    func fetchUser(id: Int) async throws -> GitHubUser
}

final class GitHubService: GitHubServiceProtocol {
    private let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchUsers(pageNumber: Int) async throws -> [GitHubUser] {
        guard let url = GitHubAPIConfig.usersURL(since: pageNumber) else { fatalError("confirm usersURL") }
        let request = makeRequest(url: url)
        return try await apiClient.send(request)
    }

    func fetchUser(id: Int) async throws -> GitHubUser {
        guard let url = GitHubAPIConfig.userURL(for: id) else { fatalError("confirm userURL") }
        let request = makeRequest(url: url)
        return try await apiClient.send(request)
    }
    
    func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        for (key, value) in GitHubAPIConfig.authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
