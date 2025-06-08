//
//  UserRowView.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Models
import SwiftUI

struct UserRowView: View {
    let user: GitHubUser

    var body: some View {
        HStack() {
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
                            .font(.title3)
                    )
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            Text(user.login)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    UserRowView(
        user: GitHubUser(
            id: 1,
            login: "id",
            avatarUrl: "",
            htmlUrl: "",
            name: "John Doe",
            followers: 100,
            following: 200
        )
    )
}
