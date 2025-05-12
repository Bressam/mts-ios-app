//
//  SomeHTTPURLResponse.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public extension HTTPURLResponse {
    static func ok(url: URL = URL(string: "https://mock.com")!,
                   statusCode: Int = 200) -> HTTPURLResponse {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
