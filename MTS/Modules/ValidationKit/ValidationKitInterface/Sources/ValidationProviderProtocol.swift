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
    /// - Parameter completion: Callback with the result (true if authenticated).
    func requestValidation(completion: @escaping (Bool) -> Void)
}
