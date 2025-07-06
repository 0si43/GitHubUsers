//
//  UserDetailView.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Models
import SwiftUI
import UIComponents

struct UserDetailView: View {
    @Bindable var viewModel: UserDetailViewModel
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let user = viewModel.user {
                    userInfoSection(user: user)
                }
                if !viewModel.nonForkedRepositories.isEmpty {
                    repositoriesSection
                }
            }
        }
        .navigationTitle("Repositories".localized)
        .navigationBarTitleDisplayMode(.inline)
        .loading($viewModel.isLoading)
        .showAlert($viewModel.showAlert, error: viewModel.error)
        .task {
            await viewModel.fetchUser()
            await viewModel.fetchRepositories()
        }
        .navigationDestination(for: GitHubRepository.self) { repository in
            WebView(urlString: repository.htmlUrl)
                .navigationTitle(repository.name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func userInfoSection(user: GitHubUser) -> some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())

            VStack {
                Text(user.login)
                    .font(.title2)
                    .fontWeight(.bold)

                if let name = user.name, !name.isEmpty {
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                }

                HStack(spacing: 24) {
                    VStack {
                        if let followers = user.followers {
                            Text("\(followers)")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text("Followers".localized)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    VStack {
                        if let following = user.following {
                            Text("\(following)")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text("Following".localized)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Divider()
                    .frame(width: 200)
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }

    private var repositoriesSection: some View {
        LazyVStack(spacing: 0) {
            ForEach(viewModel.nonForkedRepositories.indices, id: \.self) { index in
                let repository = viewModel.nonForkedRepositories[index]
                NavigationLink(value: repository) {
                    repositoryRow(repository: repository)
                }
                .buttonStyle(.plain)
                if index < viewModel.nonForkedRepositories.count - 1 {
                    Divider()
                        .padding(.leading, 16)
                }
            }
        }
    }

    private func repositoryRow(repository: GitHubRepository) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(repository.name)
                .font(.headline)
                .fontWeight(.medium)

            if let description = repository.description, !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }

            HStack {
                if let language = repository.language {
                    HStack(spacing: 4) {
                        Circle()
                            .fill(languageColor(for: language))
                            .frame(width: 12, height: 12)
                        Text(language)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text("\(repository.stargazersCount)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .contentShape(Rectangle())
    }

    private func languageColor(for language: String) -> Color {
        switch language.lowercased() {
        case "swift":
            return .orange
        case "javascript":
            return .yellow
        case "python":
            return .blue
        case "java":
            return .red
        case "kotlin":
            return .purple
        case "typescript":
            return .blue
        case "go":
            return .cyan
        case "rust":
            return .orange
        case "c++", "cpp":
            return .pink
        case "c":
            return .gray
        case "ruby":
            return .red
        case "php":
            return .indigo
        default:
            return .gray
        }
    }
}

#Preview {
    let gitHubService = GitHubServiceMock()
    gitHubService.stubUser = GitHubUser.mock(id: 1)
    let viewModel = UserDetailViewModel(userId: 1, gitHubService: gitHubService)
    return UserDetailView(viewModel: viewModel)
}
