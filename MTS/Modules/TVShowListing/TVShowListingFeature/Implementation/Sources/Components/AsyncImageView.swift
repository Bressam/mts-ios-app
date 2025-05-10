//
//  AsyncImageView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            placeholder
        }
        .clipped()
    }
    
    private var placeholder: some View {
        ProgressView()
            .background(Color.gray.opacity(0.1))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var fallback: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .background(Color.gray.opacity(0.2))
    }
}
