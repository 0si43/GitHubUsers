//
//  ContentView.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import Models
import SwiftUI
import UIComponents

public struct UserListView: View {
    @Bindable private var viewModel: UserListViewModel
    public init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        UserRowView(user: user)
                    }
                    .buttonStyle(.plain)
                }

                if !viewModel.users.isEmpty {
                    LoadMoreFooterView()
                    .onAppear {
                        Task {
                            await viewModel.fetchNextUsers()
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.fetchUsers()
            }
            .navigationTitle("GitHub Users")
            .navigationDestination(for: GitHubUser.self) { user in
                UserDetailView(
                    viewModel: UserDetailViewModel(
                        userId: user.id,
                        gitHubService: GitHubService()
                    )
                )
            }
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    let gitHubService = GitHubServiceMock()
    gitHubService.stubUsers = [
        GitHubUser.mock(id: 1),
        GitHubUser.mock(id: 2),
        GitHubUser.mock(id: 3)
    ]
    let viewModel = UserListViewModel(gitHubService: gitHubService)
    return UserListView(viewModel: viewModel)
}
