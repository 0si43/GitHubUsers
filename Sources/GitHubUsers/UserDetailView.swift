//
//  UserDetailView.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import SwiftUI

struct UserDetailView: View {
    @Bindable var viewModel: UserDetailViewModel
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }
    
    private var nonForkedRepositories: [GitHubRepository] {
        viewModel.repositories.filter { !$0.fork }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                userInfoSection
                repositoriesSection
            }
        }
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var userInfoSection: some View {
        Group {
            if let user = viewModel.user {
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
                    
                    VStack(spacing: 8) {
                        Text(user.login)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let name = user.name, !name.isEmpty {
                            Text(name)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 24) {
                            VStack(spacing: 4) {
                                if let followers = user.followers {
                                    Text("\(followers)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            VStack(spacing: 4) {
                                if let following = user.following {
                                    Text("\(following)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("Following")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.separator)),
            alignment: .bottom
        )
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

    private var repositoriesSection: some View {
        LazyVStack(spacing: 0) {
            ForEach(nonForkedRepositories.indices, id: \.self) { index in
                let repository = nonForkedRepositories[index]
                NavigationLink(value: repository) {
                    repositoryRow(repository: repository)
                }
                .buttonStyle(.plain)
                if index < nonForkedRepositories.count - 1 {
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
