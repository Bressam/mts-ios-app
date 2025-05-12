//
//  SecurityProvider.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface
import LocalAuthentication

public final class SecurityProvider: SecurityProviderProtocol {
    private let userDefaults = UserDefaults.standard
    private let pinKey = "SecurityProvider_PIN"
    
    public init() {}
    
    // MARK: - Biometric Authentication
    
    public func requestBiometricAuthentication() async -> Bool {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate using Face ID / Touch ID") { success, _ in
                continuation.resume(returning: success)
            }
        }
    }
    
    // MARK: - PIN Management
    
    public func validatePIN(_ pin: String) -> Bool {
        guard let storedPIN = userDefaults.string(forKey: pinKey) else { return false }
        return storedPIN == pin
    }
    
    public func setPIN(_ pin: String) {
        userDefaults.set(pin, forKey: pinKey)
    }
    
    public func isPINSet() -> Bool {
        return userDefaults.string(forKey: pinKey) != nil
    }
}
