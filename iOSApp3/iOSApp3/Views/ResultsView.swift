//
//  ResultsView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-20.
//

import SwiftUI

struct ResultsView: View {
    let artworks: [Artwork]
    @Binding var favorites: [Artwork]

    var body: some View {
        List(artworks) { artwork in
            NavigationLink {
                ArtworkDetailView(
                    artwork: artwork,
                    isFavorite: isFavorite(artwork),
                    onToggleFavorite: { toggleFavorite(artwork) }
                )
            } label: {
                ArtworkRowView(artwork: artwork)
            }
        }
        .listStyle(.plain)
    }

    private func isFavorite(_ artwork: Artwork) -> Bool {
        favorites.contains(where: { $0.id == artwork.id })
    }

    private func toggleFavorite(_ artwork: Artwork) {
        if let index = favorites.firstIndex(where: { $0.id == artwork.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(artwork)
        }
    }
}
