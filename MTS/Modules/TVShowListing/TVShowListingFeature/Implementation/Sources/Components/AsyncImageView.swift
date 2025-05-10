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
        Group {
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholder
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        fallback
                    @unknown default:
                        fallback
                    }
                }
            } else {
                fallback
            }
        }
        .frame(maxWidth: width, maxHeight: height)
        .clipped()
        .cornerRadius(cornerRadius)
    }
    
    private var placeholder: some View {
        ProgressView()
            .frame(maxWidth: width, maxHeight: height)
            .background(Color.gray.opacity(0.1))
    }
    
    private var fallback: some View {
        Image(systemName: "photo")
            .frame(width: width, height: height)
            .background(Color.gray.opacity(0.2))
    }
}
