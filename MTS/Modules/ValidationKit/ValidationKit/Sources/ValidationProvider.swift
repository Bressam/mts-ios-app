//
//  ValidationProvider.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI
import ValidationKitInterface
import SecurityFrameworkInterface

// MARK: - ValidationProvider Implementation
public final class ValidationProvider: ValidationProviderProtocol {
    private let securityProvider: SecurityProviderProtocol
    
    public init(securityProvider: SecurityProviderProtocol) {
        self.securityProvider = securityProvider
    }
    
    public func requestValidation() async -> Bool {
        // Try biometric authentication first
        if await securityProvider.requestBiometricAuthentication() {
            return true
        }
        
        // If biometric fails, switch to PIN
        guard await securityProvider.isPINSet() else { return false }
        
        var isAuthenticated = false
        
        for _ in 1...3 { // 3 attempts
            print("Enter PIN:")
            if let enteredPIN = readLine(), await securityProvider.validatePIN(enteredPIN) {
                isAuthenticated = true
                break
            } else {
                print("Invalid PIN. Try again.")
            }
        }
        
        return isAuthenticated
    }
}
