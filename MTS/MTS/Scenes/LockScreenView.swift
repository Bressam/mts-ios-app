//
//  LockScreenView.swift
//  MTS
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

struct LockScreenView: View {
    @ObservedObject private var viewModel: LockScreenViewModel
    
    init(viewModel: LockScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "lock.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .foregroundColor(.gray)
            
            Text("This content is locked")
                .font(.title2)
            
            Button(action: {
                Task { await viewModel.authenticate() }
            }) {
                Text("Unlock")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }.buttonStyle(BorderedProminentButtonStyle())
        }
        .padding(.horizontal, 24)
    }
}

struct LockScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenView(viewModel: .preview)
    }
}
