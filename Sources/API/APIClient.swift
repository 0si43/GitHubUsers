//
//  APIClient.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Foundation

public protocol APIClientProtocol: Sendable {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}

public final class APIClient: APIClientProtocol {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public init() {}
    
    public func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw APIError.httpError(httpResponse.statusCode)
        }

        return try decoder.decode(T.self, from: data)
    }
}
