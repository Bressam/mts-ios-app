//
//  ValidationProvider.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI
import ValidationKitInterface
import SecurityFrameworkInterface

// MARK: - ValidationProvider Implementation
public final class ValidationProvider: ValidationProviderProtocol {
    private let securityProvider: SecurityProviderProtocol
    
    public init(securityProvider: SecurityProviderProtocol) {
        self.securityProvider = securityProvider
    }
    
    public func makeValidationView(completion: @escaping (Bool) -> Void) -> AnyView {
        let viewModel = ValidationViewModel(securityProvider: securityProvider, completion: completion)
        let view = ValidationView(viewModel: viewModel)
        return AnyView(view)
    }
    
    public func makeSettingsView() -> AnyView {
        let viewModel = SecuritySettingsViewModel(securityProvider: securityProvider)
        let settingsView = SecuritySettingsView(viewModel: viewModel)
        return AnyView(settingsView)
    }
}
