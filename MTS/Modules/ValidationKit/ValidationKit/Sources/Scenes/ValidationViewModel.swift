//
//  ValidationViewModel.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface

class ValidationViewModel: ObservableObject {
    private let securityProvider: SecurityProviderProtocol
    private let completion: (Bool) -> Void
    
    @Published var isAuthenticated = false
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
    
    @MainActor func validatePIN() {
        guard securityProvider.isPINSet() else {
            errorMessage = "No PIN is set."
            return
        }
        
        if securityProvider.validatePIN(enteredPIN) {
            completion(true)
        } else {
            errorMessage = "Invalid PIN. Try again."
        }
    }
}
