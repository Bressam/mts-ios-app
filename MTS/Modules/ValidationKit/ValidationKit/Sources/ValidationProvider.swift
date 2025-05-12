//
//  ValidationProvider.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI
import ValidationModuleInterface
import SecurityFramework

// MARK: - ValidationProvider Implementation
public final class ValidationProvider: ValidationProviderProtocol {
    private let securityProvider: SecurityProviderProtocol
    
    public init(securityProvider: SecurityProviderProtocol) {
        self.securityProvider = securityProvider
    }
    
    public func requestValidation(completion: @escaping (Bool) -> Void) {
        let viewModel = ValidationViewModel(securityProvider: securityProvider) { success in
            completion(success)
        }
        
        let validationView = ValidationView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: validationView)
        hostingController.modalPresentationStyle = .fullScreen
        
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            completion(false)
            return
        }
        
        rootViewController.present(hostingController, animated: true)
    }
}
