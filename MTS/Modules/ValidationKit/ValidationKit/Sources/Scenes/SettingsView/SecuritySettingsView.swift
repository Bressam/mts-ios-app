//
//  SecuritySettingsView.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

struct SecuritySettingsView: View {
    @ObservedObject private var viewModel: SecuritySettingsViewModel
    
    init(viewModel: SecuritySettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 16) {
                headerSection
                pinInputSection
                feedbackSection
                saveButton
            }
            .padding(.horizontal, 28)
        }
    }
    
    // MARK: - Components
    private var headerSection: some View {
        VStack(alignment: .leading) {
            Text("Configure your PIN!")
                .font(.title)
                .bold()
            Text("This PIN will be used to lock your app. You can also unlock with Face ID or Touch ID if PIN is set!")
                .font(.caption)
        }
    }
    
    private var pinInputSection: some View {
        VStack(spacing: 12) {
            SecureField("New PIN", text: $viewModel.newPIN)
                .padding()
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.accentColor, lineWidth: 1))
            
            SecureField("Confirm PIN", text: $viewModel.confirmPIN)
                .padding()
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.accentColor, lineWidth: 1))
        }
    }
    
    private var feedbackSection: some View {
        VStack(spacing: 8) {
            if let success = viewModel.successMessage {
                Text(success)
                    .foregroundColor(.green)
                    .font(.caption)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            viewModel.saveNewPIN()
        }) {
            Text("Save PIN")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .foregroundColor(.white)
        .buttonStyle(BorderedProminentButtonStyle())
        .cornerRadius(12)
    }
}

#Preview {
    SecuritySettingsView(viewModel: .preview)
}
