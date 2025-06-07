//
//  ContentView.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import SwiftUI

struct UserListView: View {
    @Bindable private var viewModel: UserListViewModel
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                Button(action: {
                    // FIXME: -
                }) {
                    UserRowView(user: user)
                }
                .buttonStyle(.plain)
            }
            .refreshable {
                await viewModel.fetchUsers()
            }
            .navigationTitle("GitHub Users")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    let gitHubService = GitHubServiceMock()
    gitHubService.users = [
        GitHubUser(id: 1, login: "", avatarUrl: "", htmlUrl: "", type: ""),
        GitHubUser(id: 2, login: "", avatarUrl: "", htmlUrl: "", type: ""),
        GitHubUser(id: 3, login: "", avatarUrl: "", htmlUrl: "", type: "")
    ]
    let viewModel = UserListViewModel(gitHubService: gitHubService)
    return UserListView(viewModel: viewModel)
}
