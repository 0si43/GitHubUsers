//
//  GitHubService+.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import Foundation
import Models

// MARK: - Test & Debug

class GitHubServiceMock: GitHubServiceProtocol {
    var stubUsers: [GitHubUser] = []
    func fetchUsers(startId: Int) async throws -> [GitHubUser] {
        stubUsers
    }
    
    var stubUser: GitHubUser?
    func fetchUser(id _: Int) async throws -> GitHubUser {
        if let stubUser {
            stubUser
        } else {
            throw NSError()
        }
    }
    
    var stubRepositories: [GitHubRepository] = []
    func fetchRepositories(username: String) async throws -> [GitHubRepository] {
        stubRepositories
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
