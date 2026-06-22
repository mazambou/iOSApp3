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

    @ViewBuilder
    private var placeholderImage: some View {
        if let imageData = artwork.thumbnailImageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .interpolation(.high)
                .aspectRatio(contentMode: contentMode)
        } else {
            Image(systemName: "photo")
                .font(.title2)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
