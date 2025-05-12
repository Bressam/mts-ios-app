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
    
    init(securityProvider: SecurityProviderProtocol) {
        self.securityProvider = securityProvider
    }
    
    @MainActor
    func saveNewPIN() {
        guard !newPIN.isEmpty, newPIN == confirmPIN else {
            errorMessage = "PINs do not match."
            return
        }
        
        securityProvider.setPIN(newPIN)
        errorMessage = nil
        currentPIN = newPIN
    }
}
