//
//  SecurityProvider.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface
import LocalAuthentication

@MainActor
public final class SecurityProvider: SecurityProviderProtocol {
    public init() {}
    
    public func requestAuthentication() async -> Bool {
        if await isBiometricAvailable() {
            let biometricSuccess = await authenticateWithBiometric()
            if biometricSuccess {
                return true
            }
        }
        
        return await requestDevicePIN()
    }
    
    // MARK: - Biometric Authentication
    
    private func authenticateWithBiometric() async -> Bool {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"
        let reason = "Authenticate using Face ID or Touch ID"
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    continuation.resume(returning: true)
                } else {
                    print("Biometric Authentication Failed: \(error?.localizedDescription ?? "Unknown Error")")
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    // MARK: - System Device PIN Authentication
    
    private func requestDevicePIN() async -> Bool {
        let context = LAContext()
        let reason = "Authenticate using your device passcode"
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    continuation.resume(returning: true)
                } else {
                    print("Device PIN Authentication Failed: \(error?.localizedDescription ?? "Unknown Error")")
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    // MARK: - Biometric Availability Check
    
    private func isBiometricAvailable() async -> Bool {
        let context = LAContext()
        var error: NSError?
        let isAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return isAvailable
    }
}
