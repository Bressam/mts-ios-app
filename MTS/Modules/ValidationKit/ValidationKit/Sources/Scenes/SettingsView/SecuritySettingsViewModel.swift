//
//  SecuritySettingsViewModel.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface

final class SecuritySettingsViewModel: ObservableObject {
    private let securityProvider: SecurityProviderProtocol
    
    @Published var currentPIN = ""
    @Published var newPIN = ""
    @Published var confirmPIN = ""
    @Published var errorMessage: String?
    @Published var successMessage: String?

    init(securityProvider: SecurityProviderProtocol) {
        self.securityProvider = securityProvider
    }
    
    @MainActor
    func saveNewPIN() {
        guard !newPIN.isEmpty, newPIN == confirmPIN else {
            setErrorMessage(message: "PINs do not match.")
            return
        }
        
        securityProvider.setPIN(newPIN)
        setSuccessMessage(message: "PIN saved successfully!")
        currentPIN = newPIN
    }
    
    @MainActor
    func clearPin() {
        securityProvider.setPIN(nil)
        setSuccessMessage(message: "PIN removed successfully!")
    }
    
    private func setErrorMessage(message: String) {
        errorMessage = message
        successMessage = nil
    }
    
    private func setSuccessMessage(message: String) {
        successMessage = "PIN saved successfully!"
        errorMessage = nil
    }
}
