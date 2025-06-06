//
//  ContentView.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var service = GitHubService()
    
    var body: some View {
        NavigationView {
            Group {
                if service.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("ユーザーを読み込み中...")
                            .foregroundColor(.secondary)
                    }
                } else if let errorMessage = service.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        
                        Text("エラーが発生しました")
                            .font(.headline)
                        
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("再試行") {
                            Task {
                                await service.fetchUsers()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List(service.users) { user in
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
                        await service.fetchUsers()
                    }
                }
            }
            .navigationTitle("GitHub Users")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("更新") {
                        Task {
                            await service.fetchUsers()
                        }
                    }
                    .disabled(service.isLoading)
                }
            }
            .task {
                if service.users.isEmpty {
                    await service.fetchUsers()
                }
            }
        }
    }

}

#Preview {
    UserListView()
}
