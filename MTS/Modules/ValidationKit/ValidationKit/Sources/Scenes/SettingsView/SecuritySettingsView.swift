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
        VStack(spacing: 16) {
            SecureField("New PIN", text: $viewModel.newPIN)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(12)
            
            SecureField("Confirm PIN", text: $viewModel.confirmPIN)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(12)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Save PIN") {
                viewModel.saveNewPIN()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .padding()
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    SecuritySettingsView(viewModel: .preview)
}
