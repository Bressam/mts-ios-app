//
//  XCTest+Async.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import XCTest

enum AsyncAssertions {
    static func throwsError<T>(
        _ expression: @autoclosure @escaping () async throws -> T,
        message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected error but got none", file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
