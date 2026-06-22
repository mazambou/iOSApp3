//
//  ArtworkRowView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-21.
//

import SwiftUI

struct ArtworkRowView: View {
    let artwork: Artwork

    var body: some View {
        HStack(spacing: 12) {
            ArtworkImageView(
                artwork: artwork,
                imageURL: artwork.imageURL,
                contentMode: .fill
            )
            .frame(width: 72, height: 72)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(artwork.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(artwork.artist)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Text(artwork.dateDisplay)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
