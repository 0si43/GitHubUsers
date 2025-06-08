//
//  Test.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

@testable import GitHubUsersFeature
import Testing

@MainActor
struct UserDetailViewModelTest {
    let gitHubServiceMock: GitHubServiceMock = .init()
    let userDetailViewModel: UserDetailViewModel
    
    init() {
        userDetailViewModel = UserDetailViewModel(userId: 1, gitHubService: gitHubServiceMock)
    }
    
    @Test func fetchUser() async throws {
        let user = GitHubUser.mock(id: 1)
        gitHubServiceMock.stubUser = user
        await userDetailViewModel.fetchUser()
        #expect(userDetailViewModel.user == user)
    }

    @Test func fetchRepositories() async throws {
        let repositories = [GitHubRepository(name: "", stargazersCount: 1, fork: false, htmlUrl: "")]
        let user = GitHubUser.mock(id: 1)
        userDetailViewModel.user = user
        gitHubServiceMock.stubRepositories = repositories
        await userDetailViewModel.fetchRepositories()
        #expect(userDetailViewModel.repositories == repositories)
    }

    @Test func hideForkRepository() async throws {
        let repositories = [
            GitHubRepository(name: "not forked", stargazersCount: 1, fork: false, htmlUrl: ""),
            GitHubRepository(name: "forked", stargazersCount: 1, fork: true, htmlUrl: "")
        ]
        let user = GitHubUser.mock(id: 1)
        userDetailViewModel.user = user
        gitHubServiceMock.stubRepositories = repositories
        await userDetailViewModel.fetchRepositories()
        #expect(userDetailViewModel.nonForkedRepositories.first?.name == "not forked")
        #expect(userDetailViewModel.nonForkedRepositories.count == 1)
    }
}
