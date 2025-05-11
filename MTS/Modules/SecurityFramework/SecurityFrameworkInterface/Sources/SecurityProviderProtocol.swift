//
//  SecurityProviderProtocol.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation

public protocol SecurityProviderProtocol {
    /// Requests user authentication with PIN or biometric (if enabled).
    /// - Returns: A boolean indicating if authentication was successful.
    func requestAuthentication() async -> Bool
    
    /// Configures the user's PIN for authentication.
    /// - Parameter pin: The user's chosen PIN number.
    func setPIN(_ pin: String)
    
    /// Enables or disables biometric authentication (FaceID/TouchID).
    /// - Parameter enabled: A boolean value.
    func setBiometricAuthenticationEnabled(_ enabled: Bool)
}
