//
//  ValidationView.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

struct ValidationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ValidationViewModel
    
    init(viewModel: ValidationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            if viewModel.isUsingPIN {
                SecureField("Enter PIN", text: $viewModel.enteredPIN)
                    .keyboardType(.numberPad)
                    .padding()
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.accentColor, lineWidth: 1))
                
                Button(action: {
                    Task { await viewModel.validatePIN() }
                }) {
                    Text("Unlock")
                        .font(.headline)
                        .frame(width: 148)
                        .padding()
                }
                .foregroundColor(.white)
                .buttonStyle(BorderedProminentButtonStyle())
                .cornerRadius(12)
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
        .onChange(of: viewModel.isValidationSuccessful) { success in
            if success {
                dismiss()
            }
        }
    }
}

#Preview {
    ValidationView(viewModel: .preview)
}
