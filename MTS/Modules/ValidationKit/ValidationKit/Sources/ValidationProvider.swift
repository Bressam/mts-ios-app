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

// MARK: - ValidationViewModel
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
    
    func validatePIN() {
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

// MARK: - ValidationView
struct ValidationView: View {
    @StateObject private var viewModel: ValidationViewModel
    
    init(viewModel: ValidationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            if viewModel.isUsingPIN {
                TextField("Enter PIN", text: $viewModel.enteredPIN)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button("Unlock") {
                    viewModel.validatePIN()
                }
            } else {
                Text("Authenticating...")
                    .font(.headline)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .padding()
    }
}
