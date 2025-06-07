//
//  UserDetailViewModel.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import SwiftUI

@Observable @MainActor
final class UserDetailViewModel {
    let userId: Int
    private let gitHubService: GitHubServiceProtocol
    var user: GitHubUser?
    var repositories: [GitHubRepository] = []
    var isLoading = false
    var errorMessage: String?
    init(userId: Int, gitHubService: GitHubServiceProtocol) {
        self.userId = userId
        self.gitHubService = gitHubService
    }
    
    func fetchUser() async {
        do {
            user = try await gitHubService.fetchUser(id: userId)
        } catch {
            print(error)
        }
    }
    
    func fetchRepositories() async {
        guard let user else { return }
        do {
            repositories = try await gitHubService.fetchRepositories(username: user.login)
        } catch {
            print(error)
        }
        
    }
}
