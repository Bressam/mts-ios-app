//
//  ValidationViewModel.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface

final class ValidationViewModel: ObservableObject {
    private let securityProvider: SecurityProviderProtocol
    private let completion: (Bool) -> Void
    
    @Published var isUsingPIN = false
    @Published var enteredPIN = ""
    @Published var errorMessage: String?
    @Published var isValidationSuccessful: Bool = false
    
    init(securityProvider: SecurityProviderProtocol, completion: @escaping (Bool) -> Void) {
        self.securityProvider = securityProvider
        self.completion = completion
        startBiometricAuthentication()
    }
    
    private func startBiometricAuthentication() {
        Task { await tryBiometric() }
    }
    
    private func didValidate() {
        self.completion(true)
        isValidationSuccessful = true
    }

    private func tryBiometric() async {
        let success = await securityProvider.requestBiometricAuthentication()
        await MainActor.run {
            if success {
                didValidate()
            } else {
                self.isUsingPIN = true
            }
        }
    }
    
    func validatePIN() async {
        let success = await securityProvider.validatePIN(enteredPIN)
        await MainActor.run {
            if success {
                didValidate()
            } else {
                errorMessage = "Invalid PIN. Try again."
            }
        }
    }
}
