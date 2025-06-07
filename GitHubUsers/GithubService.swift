//
//  GitHubService.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import Foundation

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

    // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
    static func usersURL(since: Int) -> URL? {
        URL(string: "\(GitHubAPIConfig.baseURL)/users?since=\(since)")
    }
    
    // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28#get-a-user-using-their-id
    static func userURL(for id: Int) -> URL? {
        URL(string: "\(GitHubAPIConfig.baseURL)/user/\(id)")
    }
    
    // https://docs.github.com/en/rest/repos/repos#list-repositories-for-a-user
    static func repositoriesURL(username: String) -> URL? {
        URL(string: "\(GitHubAPIConfig.baseURL)/users/\(username)/repos")
    }
}

protocol GitHubServiceProtocol {
    func fetchUsers(pageNumber: Int) async throws -> [GitHubUser]
    func fetchUser(id: Int) async throws -> GitHubUser
    func fetchRepositories(username: String) async throws -> [GitHubRepository]
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

    func fetchRepositories(username: String) async throws -> [GitHubRepository] {
        guard let url = GitHubAPIConfig.repositoriesURL(username: username) else { fatalError("confirm repositoriesURL") }
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
