//
//  Request.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

public protocol NetworkClientProtocol {
    func perform<R: Request>(_ request: R) async throws -> NetworkResponse
}
