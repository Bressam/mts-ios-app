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
    
    private weak var presentingViewController: UIViewController?
    private var blurView: UIVisualEffectView?
    
    public init() {}
    
    // MARK: - Public Methods
    
    public func setPIN(_ pin: String) {
        storedPIN = pin
    }
    
    public func setBiometricAuthenticationEnabled(_ enabled: Bool) {
        isBiometricEnabled = enabled
    }
    
    public func setPresentingViewController(_ viewController: UIViewController) {
        self.presentingViewController = viewController
    }
    
    public func requestAuthentication(isDismissable: Bool = false) async -> Bool {
        guard let presentingVC = presentingViewController else {
            print("Error: No presenting view controller set.")
            return false
        }
        
        showBlurEffect(on: presentingVC.view)
        
        let isAuthenticated: Bool
        if isBiometricEnabled, await isBiometricAvailable() {
            isAuthenticated = await showBiometricOrPINAlert(in: presentingVC, isDismissable: isDismissable)
        } else {
            isAuthenticated = await handlePINAuthentication(in: presentingVC, isDismissable: isDismissable)
        }
        
        removeBlurEffect()
        return isAuthenticated
    }
    
    // MARK: - Biometric + PIN Authentication
    
    private func showBiometricOrPINAlert(in viewController: UIViewController, isDismissable: Bool) async -> Bool {
        return await withCheckedContinuation { continuation in
            let alert = UIAlertController(title: "Authentication Required", message: "Choose authentication method", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Face ID", style: .default) { _ in
                Task {
                    let success = await self.authenticateWithBiometric()
                    if success {
                        continuation.resume(returning: true)
                    } else {
                        continuation.resume(returning: await self.handlePINAuthentication(in: viewController, isDismissable: isDismissable))
                    }
                }
            })
            alert.addAction(UIAlertAction(title: "Use PIN", style: .default) { _ in
                Task {
                    continuation.resume(returning: await self.handlePINAuthentication(in: viewController, isDismissable: isDismissable))
                }
            })
            
            if isDismissable {
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {
                    _ in continuation.resume(returning: false)
                })
            }
            
            viewController.present(alert, animated: true)
        }
    }
    
    private func authenticateWithBiometric() async -> Bool {
        let context = LAContext()
        let reason = "Authenticate using Face ID or Touch ID"
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, _ in
                continuation.resume(returning: success)
            }
        }
    }
    
    // MARK: - PIN Authentication
    
    private func handlePINAuthentication(in viewController: UIViewController, isDismissable: Bool) async -> Bool {
        let isAuthenticated = await authenticateWithPIN(in: viewController, isDismissable: isDismissable)
        
        if isAuthenticated {
            return true
        } else if isDismissable {
            return false
        } else {
            // Auto-retry with PIN if not dismissable
            return await handlePINAuthentication(in: viewController, isDismissable: false)
        }
    }
    
    private func authenticateWithPIN(in viewController: UIViewController, isDismissable: Bool) async -> Bool {
        guard let storedPIN = storedPIN else { return false }
        
        return await withCheckedContinuation { continuation in
            self.showPINAlert(in: viewController, isDismissable: isDismissable) { success in
                continuation.resume(returning: success)
            }
        }
    }
    
    private func showPINAlert(in viewController: UIViewController, isDismissable: Bool, completion: @escaping (Bool) -> Void) {
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
        
        viewController.present(alert, animated: true)
    }
    
    // MARK: - Biometric Check
    
    private func isBiometricAvailable() async -> Bool {
        let context = LAContext()
        var error: NSError?
        let isAvailable = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        return isAvailable
    }
    
    // MARK: - Blur Effect Management
    
    private func showBlurEffect(on view: UIView) {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        self.blurView = blurView
    }
    
    private func removeBlurEffect() {
        blurView?.removeFromSuperview()
        blurView = nil
    }
}
