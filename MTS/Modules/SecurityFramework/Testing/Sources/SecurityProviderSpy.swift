//
//  SecurityProviderSpy.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import UIKit
import SecurityFrameworkInterface

public final class SecurityProviderSpy: SecurityProviderProtocol {
    // MARK: - Tracking Properties
    public private(set) var requestAuthenticationCallCount = 0
    public private(set) var isAuthenticationRequiredCallCount = 0
    public private(set) var setAuthenticationRequiredCallCount = 0
    
    // MARK: - Controllable Behavior
    public var shouldSucceedAuthentication = true
    public var authenticationRequired = true
    
    public init() {}
    
    // MARK: - Protocol Implementation
    
    public func requestAuthentication() async -> Bool {
        requestAuthenticationCallCount += 1
        return shouldSucceedAuthentication
    }
    
    public func setAuthenticationRequired(_ required: Bool) {
        setAuthenticationRequiredCallCount += 1
        authenticationRequired = required
    }
    
    public func isAuthenticationRequired() -> Bool {
        isAuthenticationRequiredCallCount += 1
        return authenticationRequired
    }
    
    // MARK: - Reset for Testing
    public func reset() {
        requestAuthenticationCallCount = 0
        isAuthenticationRequiredCallCount = 0
        setAuthenticationRequiredCallCount = 0
        shouldSucceedAuthentication = true
        authenticationRequired = true
    }
}
