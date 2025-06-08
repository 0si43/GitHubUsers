//
//  APIClient.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import Foundation

protocol APIClientProtocol {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}

final class APIClient: APIClientProtocol {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func send<T: Decodable>(_ request: URLRequest) async throws -> T {
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
