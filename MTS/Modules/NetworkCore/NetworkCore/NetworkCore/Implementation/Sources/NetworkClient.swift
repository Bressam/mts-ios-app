//
//  NetworkClient.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import NetworkCoreInterface

public final class NetworkClient: NetworkClientProtocol {
    public init() {}
    
    public func perform<R: HTTPNetworkRequest>(_ request: R) async throws -> HTTPNetworkResponse {
        var components = URLComponents()
        components.scheme = "https"
        components.host = request.host
        components.path = request.path
        components.queryItems = request.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        request.headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        switch request.encoding {
        case .urlEncoded:
            if let parameters = request.parameters {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                var items: [URLQueryItem] = []
                for (key, value) in parameters {
                    if let array = value as? [String] {
                        items += array.map { URLQueryItem(name: key, value: $0) }
                    } else {
                        items.append(URLQueryItem(name: key, value: "\(value)"))
                    }
                }
                components?.queryItems = items
                urlRequest.url = components?.url
            }
            
        case .jsonBody:
            if let parameters = request.parameters {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            }
        }
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw NetworkError.invalidURL
            }
            
            if !(200..<300).contains(httpResponse.statusCode) {
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode, response: httpResponse)
            }
            
            return HTTPNetworkResponse(response: httpResponse, data: data)
            
        } catch {
            throw NetworkError.underlying(error)
        }
    }
}
