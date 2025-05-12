//
//  SecurityProviderProtocol.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import UIKit

@MainActor
public protocol SecurityProviderProtocol {
    /// Requests biometric authentication (Face ID / Touch ID).
    /// - Returns: A boolean indicating if authentication was successful.
    func requestBiometricAuthentication() async -> Bool
    
    /// Validates a provided PIN.
    /// - Parameter pin: The PIN to validate.
    /// - Returns: A boolean indicating if the PIN is correct.
    func validatePIN(_ pin: String) -> Bool
    
    /// Sets a new PIN for validation.
    /// - Parameter pin: The PIN to set.
    func setPIN(_ pin: String?)
    
    /// Checks if a PIN is set.
    /// - Returns: A boolean indicating if a PIN is set.
    func isPINSet() -> Bool
}


