//
//  SecurityProviderSpy.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface

public final class SecurityProviderSpy: SecurityProviderProtocol {
    public private(set) var requestAuthenticationCallCount = 0
    public private(set) var setPINCallCount = 0
    public private(set) var setBiometricAuthenticationEnabledCallCount = 0
    
    public var shouldAuthenticateSuccessfully = true
    public var storedPIN: String?
    public var biometricEnabled = false
    
    public init() {}
    
    public func requestAuthentication(isDismissable: Bool = false) async -> Bool {
        requestAuthenticationCallCount += 1
        return shouldAuthenticateSuccessfully
    }
    
    public func setPIN(_ pin: String) {
        setPINCallCount += 1
        storedPIN = pin
    }
    
    public func setBiometricAuthenticationEnabled(_ enabled: Bool) {
        setBiometricAuthenticationEnabledCallCount += 1
        biometricEnabled = enabled
    }
}
