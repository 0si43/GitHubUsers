//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import SwiftUI

@Observable
final class UserListViewModel {
    var users: [GitHubUser] = []
    var isLoading = false
    var errorMessage: String?
    
    func fetchUsers() async {
        // …
    }
}
