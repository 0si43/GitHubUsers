//
//  APIError.swift
//  GithubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case httpError(Int)
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "無効なレスポンスです"
        case .httpError(let statusCode):
            return "HTTPエラー: \(statusCode)"
        }
    }
}
