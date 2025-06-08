//
//  UserDetailViewModel.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Models
import SwiftUI

@Observable @MainActor
final class UserDetailViewModel {
    let userId: Int
    private let gitHubService: GitHubServiceProtocol
    var user: GitHubUser?
    var repositories: [GitHubRepository] = []
    var isLoading = false
    var showAlert = false
    var error: Error?
    init(userId: Int, gitHubService: GitHubServiceProtocol) {
        self.userId = userId
        self.gitHubService = gitHubService
    }
    
    func fetchUser() async {
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            user = try await gitHubService.fetchUser(id: userId)
        } catch {
            self.error = error
            showAlert = true
        }
    }
    
    func fetchRepositories() async {
        guard let user else { return }
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            repositories = try await gitHubService.fetchRepositories(username: user.login)
        } catch {
            self.error = error
            showAlert = true
        }
        
    }
}
