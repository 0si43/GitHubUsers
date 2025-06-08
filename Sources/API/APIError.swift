//
//  APIError.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Foundation

public enum APIError: LocalizedError {
    case invalidResponse
    case httpError(Int)
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "無効なレスポンスです"
        case .httpError(let statusCode):
            return "HTTPエラー: \(statusCode)"
        }
    }
}
