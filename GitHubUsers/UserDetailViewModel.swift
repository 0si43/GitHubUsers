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
        user = try! await gitHubService.fetchUser(id: userId)
    }
}
