//
//  ValidationProviderProtocol.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

// MARK: - ValidationProviderProtocol
public protocol ValidationProviderProtocol {
    /// Requests user validation (Biometric + PIN if needed) and provides a view to present.
    /// - Parameter completion: Callback with the validation result (true if authenticated).
    /// - Returns: A SwiftUI view that can be presented.
    func makeValidationView(completion: @escaping (Bool) -> Void) -> AnyView
    
    /// Provides a settings view for setting or updating the PIN.
    /// - Returns: A SwiftUI view that can be presented.
    func makeSettingsView() -> AnyView
}
