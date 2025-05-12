//
//  TVShowRow.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import SwiftUI
import TVShowListingFeatureDomain
import TVShowListingFeatureTesting

struct TVShowRowView: View {
    let show: TVShow
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImageView(url: show.image?.medium)
                .frame(width: 60, height: 90)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(show.name)
                    .font(.headline)
                
                Text(show.genres.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Status: \(show.status)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let rating = show.rating.average {
                    Text(String(format: "Rating: %.1f ★", rating))
                        .font(.caption)
                        .foregroundColor(.orange)
                        .opacity(0.8)
                }
            }
        }
    }
}

#Preview {
    TVShowRowView(show: .mock.first!)
}
