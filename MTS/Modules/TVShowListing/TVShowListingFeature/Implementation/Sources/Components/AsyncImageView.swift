//
//  AsyncImageView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            placeholder
        }
        .frame(maxWidth: width)
        .frame(height: height)
        .clipped()
        .cornerRadius(cornerRadius)
    }
    
    private var placeholder: some View {
        ProgressView()
            .background(Color.gray.opacity(0.1))
    }
    
    private var fallback: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .background(Color.gray.opacity(0.2))
    }
}
