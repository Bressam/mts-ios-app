//
//  SecurityProvider.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI
import SecurityFrameworkInterface
import LocalAuthentication
import SecurityFrameworkInterface

public final class SecurityProvider: SecurityProviderProtocol {
    private var storedPIN: String? {
        get { UserDefaults.standard.string(forKey: "SecurityProvider_PIN") }
        set { UserDefaults.standard.setValue(newValue, forKey: "SecurityProvider_PIN") }
    }
    
    private var isBiometricEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "SecurityProvider_Biometric") }
        set { UserDefaults.standard.setValue(newValue, forKey: "SecurityProvider_Biometric") }
    }
    
    public init() {}
    
    public func setPIN(_ pin: String) {
        storedPIN = pin
    }
    
    public func setBiometricAuthenticationEnabled(_ enabled: Bool) {
        isBiometricEnabled = enabled
    }
    
    public func requestAuthentication() async -> Bool {
        if isBiometricEnabled, await isBiometricAvailable() {
            return await authenticateWithBiometric()
        } else {
            return await authenticateWithPIN()
        }
    }
    
    // MARK: - Private Methods
    
    private func authenticateWithPIN() async -> Bool {
        guard let storedPIN = storedPIN else { return false }
        
        return await withCheckedContinuation { continuation in
            let alert = UIAlertController(title: "Enter PIN", message: nil, preferredStyle: .alert)
            alert.addTextField { $0.isSecureTextEntry = true }
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                let inputPIN = alert.textFields?.first?.text ?? ""
                continuation.resume(returning: inputPIN == storedPIN)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                continuation.resume(returning: false)
            })
            
            DispatchQueue.main.async {
                self.presentAlert(alert)
            }
        }
    }
    
    private func authenticateWithBiometric() async -> Bool {
        let context = LAContext()
        let reason = "Authenticate to access the application"
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                continuation.resume(returning: success)
            }
        }
    }
    
    private func isBiometricAvailable() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        let isAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return isAvailable
    }
    
    private func presentAlert(_ alert: UIAlertController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }
        
        rootVC.present(alert, animated: true)
    }
}

