//
//  ValidationView.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

struct ValidationView: View {
    @ObservedObject private var viewModel: ValidationViewModel
    
    init(viewModel: ValidationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            if viewModel.isUsingPIN {
                SecureField("Enter PIN", text: $viewModel.enteredPIN)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button("Unlock") {
                    Task { await viewModel.validatePIN() }
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

#Preview {
    ValidationView(viewModel: .preview)
}
