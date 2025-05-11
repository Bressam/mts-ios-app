//
//  SecurityProvider.swift
//  SecurityFramework
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI
import SecurityFrameworkInterface
import LocalAuthentication

@MainActor
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
    
    // MARK: - Public API
    
    public func setPIN(_ pin: String) {
        storedPIN = pin
    }
    
    public func setBiometricAuthenticationEnabled(_ enabled: Bool) {
        isBiometricEnabled = enabled
    }
    
    public func requestAuthentication(isDismissable: Bool = false) async -> Bool {
        if isBiometricEnabled,
           await isBiometricAvailable() {
            return await showBiometricOrPINAlert(isDismissable: isDismissable)
        } else {
            return await handlePINAuthentication(isDismissable: isDismissable)
        }
    }
    
    // MARK: - Biometric + PIN Authentication
    
    private func showBiometricOrPINAlert(isDismissable: Bool) async -> Bool {
        return await withCheckedContinuation { continuation in
            let alert = UIAlertController(title: "Authentication Required", message: "Choose authentication method", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Face ID", style: .default) { _ in
                Task {
                    let success = await self.authenticateWithBiometric()
                    if success {
                        continuation.resume(returning: true)
                    } else {
                        continuation.resume(returning: await self.handlePINAuthentication(isDismissable: isDismissable))
                    }
                }
            })
            alert.addAction(UIAlertAction(title: "Use PIN", style: .default) { _ in
                Task {
                    continuation.resume(returning: await self.handlePINAuthentication(isDismissable: isDismissable))
                }
            })
            
            if isDismissable {
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {
                    _ in continuation.resume(returning: false)
                })
            }
            
            self.presentAlert(alert)
        }
    }
    
    private func authenticateWithBiometric() async -> Bool {
        let context = LAContext()
        let reason = "Authenticate using Face ID or Touch ID"
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    // MARK: - PIN Authentication
    
    private func handlePINAuthentication(isDismissable: Bool) async -> Bool {
        let isAuthenticated = await authenticateWithPIN(isDismissable: isDismissable)
        
        if isAuthenticated {
            return true
        } else if isDismissable {
            return false
        } else {
            // Auto-retry with PIN if not dismissable
            return await handlePINAuthentication(isDismissable: false)
        }
    }
    
    private func authenticateWithPIN(isDismissable: Bool) async -> Bool {
        guard let storedPIN = storedPIN else { return false }
        
        return await withCheckedContinuation { continuation in
            self.showPINAlert(isDismissable: isDismissable) { success in
                continuation.resume(returning: success)
            }
        }
    }
    
    private func showPINAlert(isDismissable: Bool, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Enter PIN", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.isSecureTextEntry = true }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let inputPIN = alert.textFields?.first?.text ?? ""
            completion(inputPIN == self.storedPIN)
        })
        
        if isDismissable {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completion(false)
            })
        }
        
        self.presentAlert(alert)
    }
    
    // MARK: - Biometric Check
    
    private func isBiometricAvailable() async -> Bool {
        let context = LAContext()
        var error: NSError?
        let isAvailable = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        return isAvailable
    }
    
    // MARK: - Alert Presentation
    
    private func presentAlert(_ alert: UIAlertController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            print("Failed to find rootViewController for alert presentation.")
            return
        }
        
        rootVC.present(alert, animated: true)
    }
}
