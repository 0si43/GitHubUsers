//
//  UserListViewModel.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Models
import SwiftUI

@Observable @MainActor
public final class UserListViewModel {
    nonisolated private let gitHubService: GitHubServiceProtocol
    var users: [GitHubUser] = []
    var isLast = false
    var isLoading = false
    var showAlert = false
    var error: Error?
    public init(gitHubService: GitHubServiceProtocol) {
        self.gitHubService = gitHubService
    }

    func fetchUsers() async {
        users = []
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            users = try await gitHubService.fetchUsers(startId: 0)
        } catch {
            self.error = error
            showAlert = true
        }
    }

    func fetchNextUsers() async {
        guard let lastUser = users.last else { return }
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let users = try await gitHubService.fetchUsers(startId: lastUser.id)
            self.users += users
            isLast = users.isEmpty
        } catch {
            self.error = error
            showAlert = true
        }
    }
}
