//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import SwiftUI

@Observable @MainActor
final class UserListViewModel {
    private let gitHubService: GitHubServiceProtocol
    var users: [GitHubUser] = []
    var isLoading = false
    var errorMessage: String?
    init(gitHubService: GitHubServiceProtocol) {
        self.gitHubService = gitHubService
    }

    func fetchUsers() async {
        // …
    }
}
