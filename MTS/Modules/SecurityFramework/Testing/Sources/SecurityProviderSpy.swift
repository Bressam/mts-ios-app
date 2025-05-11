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
    
    // MARK: - Controllable Behavior
    public var shouldSucceedBiometric = true
    public var shouldSucceedDevicePIN = true
    public var biometricAvailable = true
    
    public init() {}
    
    // MARK: - Protocol Implementation
    
    public func requestAuthentication() async -> Bool {
        requestAuthenticationCallCount += 1
        
        if biometricAvailable {
            if shouldSucceedBiometric {
                return true
            }
        }
        
        return shouldSucceedDevicePIN
    }
    
    // MARK: - Reset for Testing
    public func reset() {
        requestAuthenticationCallCount = 0
        shouldSucceedBiometric = true
        shouldSucceedDevicePIN = true
        biometricAvailable = true
    }
}
