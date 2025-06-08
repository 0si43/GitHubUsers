//
//  Test.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

@testable import GitHubUsersFeature
import Testing

@MainActor
struct UserListViewModelTest {
    let gitHubServiceMock: GitHubServiceMock = .init()
    let userListViewModel: UserListViewModel

    init() {
        userListViewModel = UserListViewModel(gitHubService: gitHubServiceMock)
    }

    @Test func fetchUsers() async throws {
        let oldUser = GitHubUser.mock(id: -99)
        userListViewModel.users = [oldUser]
        let user = GitHubUser.mock(id: 1)
        gitHubServiceMock.stubUsers = [user]
        await userListViewModel.fetchUsers()
        #expect(userListViewModel.users == [user])
    }

    @Test func fetchNextUsers() async throws {
        let oldUser = GitHubUser.mock(id: 1)
        userListViewModel.users = [oldUser]
        let newUser = GitHubUser.mock(id: 2)
        gitHubServiceMock.stubUsers = [newUser]
        await userListViewModel.fetchNextUsers()
        #expect(userListViewModel.users == [oldUser, newUser])
    }
}
