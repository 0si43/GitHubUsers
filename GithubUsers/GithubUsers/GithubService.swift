//
//  GithubService.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import SwiftUI

class GitHubService: ObservableObject {
    @Published var users: [GitHubUser] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchUsers() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        guard let url = URL(string: "https://api.github.com/users") else {
            await MainActor.run {
                errorMessage = "無効なURLです"
                isLoading = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedUsers = try JSONDecoder().decode([GitHubUser].self, from: data)
            
            await MainActor.run {
                self.users = fetchedUsers
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "データの取得に失敗しました: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}
