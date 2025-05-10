//
//  Request.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public protocol NetworkClientProtocol {
    func perform<R: HTTPNetworkRequest>(_ request: R) async throws -> HTTPNetworkResponse
}
