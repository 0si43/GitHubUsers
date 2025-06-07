//
//  GithubService.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import Foundation

// https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
private struct GitHubAPIConfig {
    static let baseURL = "https://api.github.com"
    
    static var authHeaders: [String: String] {
        return if let personalAccessToken = ProcessInfo.processInfo.environment["GITHUB_PAT"], !personalAccessToken.isEmpty {
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
    func fetchUsers(pageNumber: Int) async throws -> [GitHubUser]
}

class GitHubService: GitHubServiceProtocol {
    func fetchUsers(pageNumber: Int) async throws -> [GitHubUser] {
        let url = URL(string: "\(GitHubAPIConfig.baseURL)/users?since=\(pageNumber)")!
        let request = makeRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw APIError.invalidResponse
//        }
//        
//        guard httpResponse.statusCode == 200 else {
//            throw APIError.httpError(httpResponse.statusCode)
//        }

        return try JSONDecoder().decode([GitHubUser].self, from: data)
    }

    private func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        for (key, value) in GitHubAPIConfig.authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.setValue("GitHubSampleApp/1.0", forHTTPHeaderField: "User-Agent")
        return request
    }
}

// MARK: - Test & Debug

class GitHubServiceMock: GitHubServiceProtocol {
    var users: [GitHubUser] = []
    func fetchUsers(pageNumber: Int) async throws -> [GitHubUser] {
        users
    }
}

private extension GitHubService {
    func checkRateLimit() async throws -> RateLimitInfo {
        let url = URL(string: "\(GitHubAPIConfig.baseURL)/rate_limit")!
        let request = makeRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("🔍 Rate Limit Check Response:")
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        let rateLimitResponse = try JSONDecoder().decode(RateLimitResponse.self, from: data)
        
        // レート制限情報を詳細表示
        let rate = rateLimitResponse.rate
        print("📊 Rate Limit Details:")
        print("  Limit: \(rate.limit)")
        print("  Remaining: \(rate.remaining)")
        print("  Used: \(rate.used)")
        print("  Reset: \(Date(timeIntervalSince1970: TimeInterval(rate.reset)))")
        
        return rate
    }
}

struct RateLimitResponse: Codable {
    let rate: RateLimitInfo
}

struct RateLimitInfo: Codable {
    let limit: Int
    let remaining: Int
    let reset: Int
    let used: Int
}
