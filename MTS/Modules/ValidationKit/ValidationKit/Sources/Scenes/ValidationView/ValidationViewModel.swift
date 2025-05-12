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
    
    init(securityProvider: SecurityProviderProtocol, completion: @escaping (Bool) -> Void) {
        self.securityProvider = securityProvider
        self.completion = completion
        startBiometricAuthentication()
    }
    
    private func startBiometricAuthentication() {
        Task { await tryBiometric() }
    }
    
    private func tryBiometric() async {
        let success = await securityProvider.requestBiometricAuthentication()
        await MainActor.run {
            if success {
                self.completion(true)
            } else {
                self.isUsingPIN = true
            }
        }
    }
    
    func validatePIN() async {
        let success = await securityProvider.validatePIN(enteredPIN)
        await MainActor.run {
            if success {
                self.completion(true)
            } else {
                errorMessage = "Invalid PIN. Try again."
            }
        }
    }
}
