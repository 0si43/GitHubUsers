//
//  ContentView.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import SwiftUI

struct UserListView: View {
    @Bindable private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                Button(action: {
                    if let url = URL(string: user.htmlUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
//                            UserRowView(user: user)
                }
                .buttonStyle(PlainButtonStyle())
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
    UserListView()
}
