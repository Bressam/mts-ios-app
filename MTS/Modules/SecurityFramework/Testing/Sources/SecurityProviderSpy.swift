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
    public var requestBiometricAuthenticationCallCount = 0
    public var validatePINCallCount = 0
    public var setPINCallCount = 0
    
    public var shouldSucceedBiometric = true
    public var storedPIN: String?
    
    public init() {}
    
    public func requestBiometricAuthentication() async -> Bool {
        requestBiometricAuthenticationCallCount += 1
        return shouldSucceedBiometric
    }
    
    public func validatePIN(_ pin: String) -> Bool {
        validatePINCallCount += 1
        return storedPIN == pin
    }
    
    public func setPIN(_ pin: String?) {
        setPINCallCount += 1
        storedPIN = pin
    }
    
    public func isPINSet() -> Bool {
        return storedPIN != nil
    }
}
