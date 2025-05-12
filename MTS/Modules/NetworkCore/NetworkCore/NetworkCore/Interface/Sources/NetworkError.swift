//
//  NetworkError.swift
//  NetworkCore
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int, response: HTTPURLResponse)
    case underlying(Error)
}
