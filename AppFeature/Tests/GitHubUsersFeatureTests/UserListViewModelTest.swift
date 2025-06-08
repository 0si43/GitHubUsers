//
//  Test.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

import Testing
import Models

struct UserListViewModelTest {
    let gitHubServiceMock: GitHubServiceMock = .init()
    let userListViewModel = UserListViewModel(gitHubService: gitHubServiceMock)
    
    @Test func fetchUsers() async throws {
        gitHubServiceMock.users = []
        #expect(false)
    }
    
    @Test func fetchUsers() async throws {
        gitHubServiceMock.users = []
        #expect(false)
    }
}
