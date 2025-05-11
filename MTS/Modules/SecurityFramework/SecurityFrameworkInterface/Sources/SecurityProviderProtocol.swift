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
    /// Sets the view controller that will present authentication alerts (PIN, biometric, etc.)
    /// - Parameter viewController: The UIViewController to present authentication UI over.
    func setPresentingViewController(_ viewController: UIViewController)
    
    /// Requests user authentication with PIN or biometric (if enabled).
    /// - Parameter isDismissable: If true, allows the user to cancel authentication.
    /// - Returns: A boolean indicating if authentication was successful.
    func requestAuthentication(isDismissable: Bool) async -> Bool
    
    /// Configures the user's PIN for authentication.
    /// - Parameter pin: The user's chosen PIN number.
    func setPIN(_ pin: String)
    
    /// Enables or disables biometric authentication (FaceID/TouchID).
    /// - Parameter enabled: A boolean value.
    func setBiometricAuthenticationEnabled(_ enabled: Bool)
}
