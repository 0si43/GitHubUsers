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
        NavigationStack {
            List(viewModel.users) { user in
                NavigationLink(value: user) {
                     UserRowView(user: user)
                }
                .buttonStyle(.plain)
            }
            .refreshable {
                await viewModel.fetchUsers()
            }
            .navigationTitle("GitHub Users")
            .navigationDestination(for: GitHubUser.self) { user in
                UserDetailView(user: user, repositories: [])
            }
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    let gitHubService = GitHubServiceMock()
    gitHubService.users = [
        GitHubUser.mock(id: 1),
        GitHubUser.mock(id: 2),
        GitHubUser.mock(id: 3)
    ]
    let viewModel = UserListViewModel(gitHubService: gitHubService)
    return UserListView(viewModel: viewModel)
}
