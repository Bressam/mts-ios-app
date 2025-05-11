//
//  HTTPRequest.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public protocol HTTPNetworkRequest {
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoding: RequestEncoding { get }
    var method: HTTPMethod { get }
}

public extension HTTPNetworkRequest {
    var queryItems: [URLQueryItem]? { nil }
    
    var headers: [String: String]? { nil }
    
    var parameters: [String: Any]? { nil }
    
    var encoding: RequestEncoding { .urlEncoded }
    
    var method: HTTPMethod { .get }
}
