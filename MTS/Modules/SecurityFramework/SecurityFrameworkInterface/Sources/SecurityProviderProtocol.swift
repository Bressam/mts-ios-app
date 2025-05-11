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
    /// Requests user authentication using native biometric (Face ID / Touch ID) and device PIN (system passcode).
    /// - Returns: A boolean indicating if authentication was successful.
    func requestAuthentication() async -> Bool
    
    /// Gets if authentication is required.
    /// - Returns: A boolean indicating if authentication is required.
    func isAuthenticationRequired() -> Bool
    
    /// Sets if authentication is required.
    /// - Parameter required: A boolean value.
    func setAuthenticationRequired(_ required: Bool)
}


