//
//  HTTPResponse.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct NetworkResponse {
    public let response: HTTPURLResponse
    public let data: Data
    
    public var statusCode: Int {
        response.statusCode
    }
    
    public init(response: HTTPURLResponse, data: Data) {
        self.response = response
        self.data = data
    }
}
