//
//  UserDetailView.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import SwiftUI

struct UserDetailView: View {
    let user: GitHubUser
    let repositories: [GitHubRepository]

    private var nonForkedRepositories: [GitHubRepository] {
        repositories.filter { !$0.fork }
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
                        Text("\(user.followers)")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 4) {
                        Text("\(user.following)")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
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
    }

    private var repositoriesSection: some View {
        LazyVStack(spacing: 0) {
            ForEach(nonForkedRepositories.indices, id: \.self) { index in
                let repository = nonForkedRepositories[index]
                repositoryRow(repository: repository)
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
    UserDetailView(user: GitHubUser.mock(id: 1), repositories: [])
}
