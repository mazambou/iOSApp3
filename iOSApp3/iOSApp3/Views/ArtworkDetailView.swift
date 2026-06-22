//
//  ArtworkDetailView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-20.
//

import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                ArtworkImageView(
                    artwork: artwork,
                    imageURL: artwork.largeImageURL,
                    contentMode: .fit
                )
                .frame(maxWidth: .infinity, minHeight: 240)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 8) {
                    Text(artwork.title)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(artwork.artist)
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text(artwork.dateDisplay)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Divider()

                detailSection(title: "Medium", value: artwork.medium)
                detailSection(title: "Origin", value: artwork.placeOfOrigin)
                detailSection(title: "Description", value: artwork.description)
            }
            .padding()
        }
        .navigationTitle("Artwork Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onToggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                }
                .accessibilityLabel(isFavorite ? "Remove favorite" : "Add favorite")
            }
        }
    }

    private func detailSection(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            Text(value.isEmpty ? "No information available." : value)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }
}
