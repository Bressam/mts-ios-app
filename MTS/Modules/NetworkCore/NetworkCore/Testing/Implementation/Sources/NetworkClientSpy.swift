//
//  NetworkClientSpy.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import NetworkCoreInterface

/// Spy for `NetworkClientProtocol`. Besides the list of performedRequests and count of them, it allows to provide expected response, responseData and error to be thrown
public final class NetworkClientSpy: NetworkClientProtocol {
    public private(set) var performedRequests: [Any] = []
    public private(set) var callCount = 0
    public var errorToThrow: Error?
    public var responseData: Data?
    public var expectedResponse: HTTPURLResponse

    public init(expectedResponse: HTTPURLResponse) {
        self.expectedResponse = expectedResponse
    }
    
    public func perform<R: Request>(_ request: R) async throws -> NetworkResponse {
        performedRequests.append(request)
        callCount += 1
        
        if let error = errorToThrow {
            throw(error)
        }

        return NetworkResponse(response: expectedResponse, data: responseData ?? .init())
    }
}
