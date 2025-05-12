//
//  ValidationProviderProtocol.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

// MARK: - ValidationProviderProtocol
public protocol ValidationProviderProtocol {
    /// Requests user validation (Biometric + PIN if needed).
    /// - Returns: A boolean indicating if authentication was successful.
    func requestValidation() async -> Bool
}
