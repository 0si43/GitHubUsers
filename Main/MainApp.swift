//
//  GitHubUsersApp.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/06.
//

import GitHubUsersFeature
import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(
                viewModel: UserListViewModel(
                    gitHubService: GitHubService()
                )
            )
        }
    }
}
