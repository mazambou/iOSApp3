//
//  ArtworkImageView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-21.
//

import SwiftUI

struct ArtworkImageView: View {
    let artwork: Artwork
    let imageURL: URL?
    let contentMode: ContentMode

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                placeholderImage
                    .overlay {
                        ProgressView()
                    }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure:
                placeholderImage
            @unknown default:
                placeholderImage
            }
        }
        .accessibilityLabel(artwork.thumbnailAltText ?? artwork.title)
    }

    private var placeholderImage: some View {
        // Displayed while the image loads or if the remote image fails.
        Image(systemName: "photo")
            .font(.title2)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
