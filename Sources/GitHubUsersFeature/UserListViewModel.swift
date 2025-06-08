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
    private let gitHubService: GitHubServiceProtocol
    var users: [GitHubUser] = []
    var isLoading = false
    var errorMessage: String?
    public init(gitHubService: GitHubServiceProtocol) {
        self.gitHubService = gitHubService
    }

    func fetchUsers() async {
        do {
            users = try await gitHubService.fetchUsers(pageNumber: 0)
        } catch {
            print(error)
        }
    }
}
