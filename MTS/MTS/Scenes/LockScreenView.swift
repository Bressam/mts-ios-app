//
//  LockScreenView.swift
//  MTS
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI

struct LockScreenView: View {
    @StateObject private var viewModel: LockScreenViewModel
    
    init(viewModel: LockScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: viewModel.isUnlocked ? "lock.open.fill" : "lock.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .foregroundColor(.gray)
                .scaleEffect(viewModel.isUnlocked ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3)
                    .repeatCount(viewModel.isUnlocked ? 1 : 0, autoreverses: true),
                           value: viewModel.isUnlocked)
            
            Text(viewModel.isUnlocked ? "This content is unlocked" : "This content is locked")
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
        .onChange(of: viewModel.isUnlocked) { _ in
            viewModel.finishedUnlocking()
        }
    }
}

struct LockScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenView(viewModel: .preview)
    }
}
