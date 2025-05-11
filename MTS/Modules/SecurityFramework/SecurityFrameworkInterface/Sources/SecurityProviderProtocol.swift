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
}


